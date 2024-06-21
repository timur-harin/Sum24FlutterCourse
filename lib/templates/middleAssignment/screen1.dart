import 'package:education/templates/middleAssignment/TimerScreen.dart';
import 'package:education/templates/middleAssignment/screen2.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget{
  const Screen1({super.key});

  @override
    State<Screen1> createState() => _Screen1State();
  
}
//
class _Screen1State extends State<Screen1>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(
      title: Text('ShowerHelper'),
    ),
    body: Center(
   child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
      ElevatedButton(onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TimerScreen()));
      }, child: Text('Начать душ')),
      ElevatedButton(onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Screen2()));
      }, child: Text('История'))
    ],
    ),
    )
    );
  }
}