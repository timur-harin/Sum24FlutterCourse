import 'dart:async';
import 'dart:convert';

import 'package:education/templates/middleAssignment/data/providers/session_history.dart';
import 'package:education/templates/middleAssignment/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/providers/user_preferences_provider.dart';

class SummaryScreen extends StatefulWidget {
  final int time;

  const SummaryScreen({
    required this.time,
    super.key,
  });

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  List<SessionHistory> historyList = [];

  @override
  void initState() {
    super.initState();
    _loadSessionHistory();
  }

  Future<void> _loadSessionHistory() async {
    historyList = await getSessionHistoryData();
    setState(() {}); // Update the UI with the new data
  }


  Future<List<SessionHistory>> getSessionHistoryData() async {
    var prefs = await SharedPreferences.getInstance();
    final encodedHistoryList = prefs.getStringList('sessionHistoryData');

    if (encodedHistoryList == null) return [];

    final historyList = encodedHistoryList.map((encodedHistory) {
      final decodedHistory = json.decode(encodedHistory);
      return SessionHistory.fromJson(decodedHistory);
    }).toList();

    return historyList;
  }

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
                  await _setSessionHistoryData(historyList);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text('Save')
            ),
          ],
        ),
      ),
    );
  }

  Future _setSessionHistoryData(List<SessionHistory> historyList) async {
    var prefs = await SharedPreferences.getInstance();

    final sessionHistoryData = SessionHistory(time: widget.time, rating: rate);
    historyList.add(sessionHistoryData);

    final encodedHistoryList = historyList.map((history) => json.encode(history.toJson())).toList();
    prefs.setStringList('sessionHistoryData', encodedHistoryList);
  }

  Future<void> _storeSessionHistoryData(List<SessionHistory> historyList) async {
    var prefs = await SharedPreferences.getInstance();
    final encodedHistoryList = historyList.map((history) => json.encode(history.toJson())).toList();
    prefs.setStringList('sessionHistoryData', encodedHistoryList);
  }

}
