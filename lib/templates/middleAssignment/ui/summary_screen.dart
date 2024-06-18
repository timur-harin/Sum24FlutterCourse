import 'dart:async';
import 'dart:convert';

import 'package:education/templates/middleAssignment/data/providers/session_history.dart';
import 'package:education/templates/middleAssignment/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SummaryScreen extends StatefulWidget {
  final int time;
  final int countOfPhases;

  const SummaryScreen({
    required this.countOfPhases,
    required this.time,
    super.key,
  });

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total time: ${widget.time} min', style: TextStyle(fontSize: 25),),
            const SizedBox(height: 20,),
            Text('Count of phases: ${widget.countOfPhases}', style: TextStyle(fontSize: 20),),
            const SizedBox(height: 20,),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                rate = rating;
                print(rating);
              },
            ),
            SizedBox(height: 20,),
            TextButton(
                onPressed: () async {
                  await _setSessionHistoryData();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text('Save')
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setSessionHistoryData() async {
    var prefs = await SharedPreferences.getInstance();
    final sessionHistoryData = SessionHistory(countOfPhases: widget.countOfPhases,
        time: widget.time, rating: rate);

    final encodedHistoryList = prefs.getStringList('sessionHistoryData');
    if (encodedHistoryList == null) {
      prefs.setStringList('sessionHistoryData', [json.encode(sessionHistoryData.toJson())]);
    } else {
      encodedHistoryList.add(json.encode(sessionHistoryData.toJson()));
      prefs.setStringList('sessionHistoryData', encodedHistoryList);
    }
  }
}