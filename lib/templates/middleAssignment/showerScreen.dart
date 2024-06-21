//import 'dart:ui';
import 'package:education/templates/middleAssignment/showerSession.dart';
import 'package:education/templates/middleAssignment/summaryScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ShowerScreen extends StatefulWidget{
  const ShowerScreen({super.key});

  @override
  State<StatefulWidget> createState() => Shower();


}


class Shower extends State<ShowerScreen>{
  Shower(){
    time = DataHelper.infoList[index].duration;
    currentColor = DataHelper.infoList[index].color;
    temperature =DataHelper.infoList[index].label;
    currentIcon = onPause;
    startCountDown();
  }

  int time = 60;
  int dcr = 1;
  final Icon onPlay = Icon(Icons.play_arrow);
  final Icon onPause = Icon(Icons.pause);
  Icon currentIcon = Icon(Icons.smoking_rooms);
  String playPause = "pause";
  Color? currentColor;
  String? temperature;
  int numberOfPhases = DataHelper.infoList.length;
  int index = 0;
  int totalTime = 0;

  void startCountDown(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(mounted){
        totalTime+=dcr;
        if (time > 0) {
          setState(() {
            time-=dcr;
          });
        }
        else {
          setState(() {
            index++;
            if(numberOfPhases - index <= 0){
              timer.cancel();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryScreen(time: totalTime,)));
            }
            else{
              time = DataHelper.infoList[index].duration;
              currentColor = DataHelper.infoList[index].color;
              temperature =DataHelper.infoList[index].label;
            }
          });
      }
    }});
  }

  @override
  Widget build(BuildContext context) {
    //startCountDown();
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion', style: TextStyle(fontSize: 30.0),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Phases left: ${numberOfPhases - index}", style: TextStyle(fontSize: 25),),
            Text(temperature!, style: TextStyle(fontSize: 25)),
            Text("Time left: ${time~/60} Min. ${time%60} Sec.", style: TextStyle(fontSize: 50)),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          FloatingActionButton.extended(
            heroTag: "next",
            onPressed: (){
              time = 0;
            },
            icon: Icon(Icons.arrow_forward),
            label: Text("next phase"),),
          FloatingActionButton.extended(
            heroTag: "pause",
            onPressed: (){
              dcr += 1;
              dcr %= 2;
              if(dcr == 0){
                currentIcon = onPlay;
                playPause = "play";
              }else{currentIcon = onPause;playPause = "pause";}
            },
            icon: currentIcon,
            label: Text(playPause),),
          FloatingActionButton.extended(
            heroTag: "finish",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryScreen(time: totalTime,)));
            },
            icon: Icon(Icons.flag),
            label: Text("finish"),)
        ],
      ),
      backgroundColor: currentColor,
    );
  }
}

/*class TimerWidget extends StatefulWidget{
  const TimerWidget({super.key});

  @override
  State<StatefulWidget> createState() => TimeCounter();
}

class TimeCounter extends State<TimerWidget>{
  int time = 60;
  void startCountDown(){
    Timer.periodic(Duration(seconds: time), (timer){
      if(time > 0) {
        setState(() {
          time--;
        });
      }});
  }
  @override
  Widget build(BuildContext context) {
    startCountDown();
    return Text("Time left: ${time~/60} Min. ${time%60} Sec.", style: TextStyle(fontSize: 50));
  }
}

final timeProvider = ChangeNotifierProvider((ref){
  return TimeNotifier();
});
class TimeNotifier extends ChangeNotifier{
  int _time = 60;
  get time => _time;
  void dcr(){
    _time--;
    notifyListeners();
  }
  bool notNull(){
    return _time>0;
  }

}*/