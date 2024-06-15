import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:education/templates/middleAssignment/HomeScreen/HomePage.dart' as home_page;

class DataSaver extends StatelessWidget{

  Duration time = Duration();

  DataSaver({required this.time});

  @override
  Widget build(BuildContext context) {
    final _temperatureController = TextEditingController();
    final _notesController = TextEditingController();

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(time.inMinutes.remainder(60));
    final seconds = twoDigits(time.inSeconds.remainder(60));

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Color(0xFFFFFDD6),
      child: Container(
        width: 400,
        height: 450,
        alignment: Alignment.center,
        child: Column (
          children: [
            Text ("Save Data", style: TextStyle(fontSize: 20),),
            Text("Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"), 
            Text("Time: $minutes:$seconds"),
            Spacer(),
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
                    // maxLength: 4,
                    decoration: InputDecoration(
                      hintText: 'Enter Temperature',
                      hintStyle: TextStyle(fontSize: 12.0),
                      border: OutlineInputBorder(),
                    ),
                  )
                )
              ]
            ),
            Spacer(),
            SizedBox(
              
              width: 300,
              height: 270,
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
              )
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white
                ),
                ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700
              ),
            ),
            Spacer()
          ]
        ),
      )
    );
  }

}

