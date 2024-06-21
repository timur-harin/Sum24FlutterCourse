import 'dart:async';
import 'package:flutter/material.dart';
import 'Finish.dart';
import 'providerS.dart';
//import 'package:stopwatch_countdown/stopwatch_countdown.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();

}

class _SettingState extends State<Setting> {

  static final int minut = ShowerProvider().time;
  

  static final countdownDuration = Duration(minutes: 2);
  Duration duration = const  Duration();
  Timer? timer;

  bool isCountDown = true;

  @override
  void initState() {
    super.initState();
    
    //startTime();
    reset();
    
  }

  void reset(){
    if(isCountDown){
      setState(() => duration = countdownDuration);
    }
    else{
      setState(() => duration = Duration());
    }
  }

  void addTime(){
    final addSeconds = isCountDown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if(seconds < 0){
        timer?.cancel();
      }
      else{
      duration = Duration(seconds: seconds);
      }
    });
  }

  void startTime({bool resets = true}){

  if(resets){
    reset();
  }


  timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());

  }

void stopTimer({bool resets = true}){
  if(resets){
    reset();
  }

  setState(() => timer?.cancel());
}

  @override
 Widget build(BuildContext context)
 {
  return Scaffold(

  backgroundColor: Colors.blue,


  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTime(),
        buildButton(),  
         Text ('$minut'),



         

      ],
    ),
  ),
  );
 }


  Widget buildTime() {

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));


    return Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        buildTimeCard(time: minutes, header: 'Minutes'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'Seconds'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}){
    return Container(

      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      
      child : Text(

        time, 
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color:  Color.fromARGB(255, 232, 178, 236),
          fontSize: 72,
        )
      ),
    );
  }

 Widget buildButton() {
  final isRunning = timer == null ? false : timer!.isActive;
  //final isComplited = duration.inSeconds == 0;

  if (isRunning == true ) {

     return Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        const SizedBox(width: 12),

        ElevatedButton(
          onPressed: () {
            stopTimer();
          },
    
          child: Text('CANCEL'),
          
        ),
      ],
    );
  } else {

    return Container(

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(iconColor: Color.fromARGB(26, 238, 0, 255)),
        onPressed: () {
          startTime();
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Start Timer!',),
            Icon(Icons.flag, color: Color.fromARGB(255, 9, 160, 242)),
          ],
        ),
      ),
    );
  }
 }
    
}

