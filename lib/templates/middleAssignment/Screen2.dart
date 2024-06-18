import 'package:education/templates/middleAssignment/TimerScreen.dart';
import 'package:education/templates/middleAssignment/TimerScreen2.dart';
import 'package:education/templates/middleAssignment/screen2.dart';
import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget{
  const Screen2({super.key});

  @override
    State<Screen2> createState() => _Screen2State();
  
}

class _Screen2State extends State<Screen2>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(
    ),
    body: Center(
   child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('History'),
        
    ],
    ),
    )
    );
  }
}