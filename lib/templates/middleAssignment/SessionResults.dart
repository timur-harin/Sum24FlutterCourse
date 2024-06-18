import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/newShower.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  int time = 10;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Session Results'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text('time'),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('$time'),
          )
        ],
      ),
    );
  }
}
