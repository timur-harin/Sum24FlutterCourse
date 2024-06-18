import 'dart:convert';

import 'package:education/templates/middleAssignment/data.dart';
import 'package:education/templates/middleAssignment/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionSummaryScreen extends StatefulWidget {
  final int remainingHot;
  final int remainingCold;
  final int time;
  final int hotCount;
  final int coldCount;

  const SessionSummaryScreen({
    super.key,
    required this.remainingCold,
    required this.remainingHot,
    required this.time,
    required this.coldCount,
    required this.hotCount,
  });

  @override
  _SessionSummaryScreenState createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends State<SessionSummaryScreen> {
  int _rating = 0;
  final historyDataKey = 'history_data';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Session summary',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total time: ${widget.time} min',
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            Text(
              'Number of stages completed: ${widget.hotCount - widget.remainingHot + widget.coldCount - widget.remainingCold}',
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            Text(
              'Rate your experience:',
              style: const TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_rating >= 1? Icons.star : Icons.star_border, color: const Color.fromARGB(255, 197, 177, 5), size: 40,),
                  onPressed: () {
                    setState(() {
                      _rating = 1;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(_rating >= 2? Icons.star : Icons.star_border, color: const Color.fromARGB(255, 197, 177, 5), size: 40),
                  onPressed: () {
                    setState(() {
                      _rating = 2;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(_rating >= 3? Icons.star : Icons.star_border, color: const Color.fromARGB(255, 197, 177, 5), size: 40),
                  onPressed: () {
                    setState(() {
                      _rating = 3;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(_rating >= 4? Icons.star : Icons.star_border, color: const Color.fromARGB(255, 197, 177, 5), size: 40),
                  onPressed: () {
                    setState(() {
                      _rating = 4;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(_rating >= 5? Icons.star : Icons.star_border, color: const Color.fromARGB(255, 197, 177, 5), size: 40),
                  onPressed: () {
                    setState(() {
                      _rating = 5;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                fixedSize: const Size(120, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                
              ),
              onPressed: () async {
                await _setHistoryData();
                
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              child: const Text('Finish', style:TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _setHistoryData() async {
    var prefs = await SharedPreferences.getInstance();
    final historyData = HistoryData(rating: _rating, stages: widget.hotCount - widget.remainingHot + widget.coldCount - widget.remainingCold, totalTime: widget.time);
    final encodeHistoryList = prefs.getStringList('historyData');
    if (encodeHistoryList == null) {
       prefs.setStringList('historyData', [json.encode(historyData.toJson())]);
  
    } else {
      encodeHistoryList.add(json.encode(historyData.toJson()));
      prefs.setStringList('historyData', encodeHistoryList);
    }
  }
   
}