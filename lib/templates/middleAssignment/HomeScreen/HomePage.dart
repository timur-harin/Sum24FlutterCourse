import 'package:education/templates/middleAssignment/HomeScreen/DataSaver.dart';
import 'package:education/templates/middleAssignment/Shower/SessionSettings.dart';
import 'package:flutter/material.dart';

import 'dart:async';

// import 'package:education/templates/middleAssignment/HomeScreen/DataSaver.dart';
import 'package:education/templates/middleAssignment/HomeScreen/DataSaver.dart' as data_saver;
import 'package:education/templates/middleAssignment/HomeScreen/Statistic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDD0),
      body: Center(
        child: statistics()
      ),
      
      bottomNavigationBar: BottomAppBar(
        child: buttons(),
      ),
    );
  }

  Widget buttons() {
  return Container(
    width: 250.0,
    height: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
       // Rounded border for the container
    ),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProviderScope(child: SessionSettings())),
        );
      },
      style: ElevatedButton.styleFrom(
        // padding: EdgeInsets.all(20.0),
        backgroundColor: Colors.blue[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded border for the button
        ),
      ),
      child: Text(
        'START SESSION',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
  );
}

  Widget statistics() {
    return StatisticPage();
  }
}

