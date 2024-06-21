import 'package:education/templates/middleAssignment/HomeScreen/HomePage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:education/templates/middleAssignment/Storage/ShowerHistory.dart';
import 'package:education/templates/middleAssignment/Storage/SharedPreferencesService.dart';
import 'package:education/templates/middleAssignment/Shower/SessionInfo.dart';

class Statisticinfo extends StatefulWidget {
  final String name;
  final Duration time;
  final List<SessionInfo> sessions;
  final String notes;
  final double temperature;

  Statisticinfo({required this.name, required this.time, required this.sessions, required this.notes, required this.temperature});

  @override
  _Statisticinfo createState() => _Statisticinfo();
}

class _Statisticinfo extends State<Statisticinfo> {
  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(widget.time.inMinutes.remainder(60));
    final seconds = twoDigits(widget.time.inSeconds.remainder(60));
    
    final _temperatureController = TextEditingController(text: widget.temperature.toString());
    final _notesController = TextEditingController(text: widget.notes);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Color(0xFFFFFDD6),
      child: Container(
        width: 400,
        height: 600,
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Text("Name: ${widget.name}"),
            SizedBox(height: 10.0),
            Text("Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"),
            SizedBox(height: 10.0),
            Text("Time: $minutes:$seconds"),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Temperature: "),
                SizedBox(
                  width: 130,
                  height: 30,
                  child: TextField(
                    controller: _temperatureController,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Enter Temperature',
                      hintStyle: TextStyle(fontSize: 12.0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 300,
              height: 100,
              child: TextField(
                maxLines: null,
                minLines: 1,
                controller: _notesController,
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Any notes',
                  hintStyle: TextStyle(fontSize: 12.0),
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.sessions.length,
                itemBuilder: (context, index) {
                  final session = widget.sessions[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: session.color,
                        radius: 10,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Time: ${(session.realTime ~/ 60).toString().padLeft(2,'0')}:${(session.realTime % 60).toString().padLeft(2,'0')}',
                      ),
                    ],
                  );
                },
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
