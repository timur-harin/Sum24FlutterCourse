import 'package:flutter/material.dart';
import 'dart:async';

import 'package:education/templates/middleAssignment/Storage/ShowerHistory.dart';
import 'package:education/templates/middleAssignment/Storage/SharedPreferenciesServise.dart';
import 'package:education/templates/middleAssignment/Shower/SessionInfo.dart';

class DataSaver extends StatefulWidget {
  final String name;
  final Duration time;
  final List<SessionInfo> sessions;

  DataSaver({required this.name, required this.time, required this.sessions});

  @override
  _DataSaverState createState() => _DataSaverState();
}

class _DataSaverState extends State<DataSaver> {
  final _temperatureController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(widget.time.inMinutes.remainder(60));
    final seconds = twoDigits(widget.time.inSeconds.remainder(60));

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
                        backgroundColor: session.color == Colors.red
                            ? Colors.red
                            : Colors.blue,
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
                final temperature = double.tryParse(_temperatureController.text) ?? 0.0;
                final notes = _notesController.text;
                final newSession = ShowerHistory(
                  date: DateTime.now(),
                  duration: widget.time.inSeconds,
                  sessions: widget.sessions,
                  notes: notes,
                  temperature: temperature,
                );

                final SharedPreferencesService service = SharedPreferencesService();
                await service.saveShowerSession(newSession);

                Navigator.of(context).pop();
              },
              child: Text(
                "Save",
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
