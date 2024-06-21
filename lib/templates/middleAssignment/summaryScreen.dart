import 'package:education/templates/middleAssignment/mainScreen.dart';
import 'package:education/templates/middleAssignment/showerSession.dart';
import 'package:education/templates/middleAssignment/temperaturePhase.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget{
  int time;
  HistoryBox? box;
  List<Widget> phaseList = [];
  SummaryScreen({super.key, required this.time}){
    box = HistoryBox(completeTime: time, phases: DataHelper.infoList);
    for(TemperaturePhaseInfo info in box!.phases){
      phaseList.add(PhaseReportWidget(localPhase: info));
    }
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Session info"),
      ),
      body: Column(
          children: [
            Text("Session total time: ${box!.completeTime~/60} Min. ${box!.completeTime%60} Sec."),
            Text("Session planned time: ${box!.fullTime~/60} Min. ${box!.fullTime%60} Sec."),
            Column(children: phaseList,)

          ],
        ),

      bottomNavigationBar: NavigationBar(
        destinations: [
          FloatingActionButton.extended(
            heroTag: "home",
              onPressed: (){
                DataStorage.data.add(box!);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            label: Text("Return to home page"),
          icon: Icon(Icons.home),),
          FloatingActionButton.extended(
            heroTag: "new session",
            onPressed: (){
              DataStorage.data.add(box!);
              Navigator.popUntil(context, ModalRoute.withName('/SetUp'));
            },
            label: Text("Start new session"),
          icon: Icon(Icons.add_box),),
        ],
      ),
      //backgroundColor: Colors.cyanAccent,
    );
  }
}
class HistoryBox{
  List<TemperaturePhaseInfo> phases;
  late int fullTime;
  int completeTime;
  String? day;
  String? dayTime;
  HistoryBox({required this.completeTime, required this.phases}){
    fullTime = 0;
    review();
  }
  void review(){
    int temporaryTime = completeTime;
    for(TemperaturePhaseInfo info in phases){
      fullTime += info.duration;
      if(temporaryTime >= info.duration){
        info.status = "Complete";
      }else if(temporaryTime > 0){
        info.status = "Unfinished";
      }else{
        info.status = "Not started";
      }
      temporaryTime -= info.duration;
    }
  }
}
class PhaseReportWidget extends StatelessWidget{
  TemperaturePhaseInfo localPhase;
  PhaseReportWidget({super.key, required this.localPhase});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: localPhase.color,
          child: Row(
            children: [
              Text("${localPhase.label} Phase"),
              Text("${localPhase.duration~/60} Min. ${localPhase.duration%60} Sec.")
            ],
          ),
        ),
        Text(localPhase.status ?? "Bob")
      ],
    );
  }
}
