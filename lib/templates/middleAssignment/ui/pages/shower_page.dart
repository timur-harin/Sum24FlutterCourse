import 'dart:async';

import 'package:flutter/material.dart';

class ShowerPage extends StatefulWidget {
  const ShowerPage({super.key});

  @override
  State<ShowerPage> createState() => _ShowerPageState();
}

class _ShowerPageState extends State<ShowerPage> {

   int numbOfCycles = 4;
   int timeInMinutes = 0;
   void startTimer (int numbOfCycles,int timeInCycle ){
const oneSec = const Duration(seconds: 1);
// timeLeft = numbOfCycles * timeInCycle;

//   Timer.periodic(oneSec, (Timer t) {
//    }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shower'),
        ),
        body:  Center(
          child: Column(

            children: [
              ElevatedButton(onPressed: (){}, child: Text("")),
              Text('Shower Page'),
            ],
          ),
        ));
  }
}
