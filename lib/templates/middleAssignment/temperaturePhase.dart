import 'package:education/templates/middleAssignment/showerSession.dart';
import 'package:flutter/material.dart';

class TemperatureWidget extends StatefulWidget{
  const TemperatureWidget({super.key});


  @override
  State<TemperatureWidget> createState() => TemperaturePhase();



}

class TemperaturePhase extends State<TemperatureWidget>{
  TemperaturePhaseInfo info = TemperaturePhaseInfo();
  TemperaturePhase(){
    DataHelper.infoList.add(info);
  }

  @override
  Widget build(BuildContext context) {
    Color color_ = Colors.blueAccent;
    if(info.hot){color_ = Colors.red;}
    return Container(
        child: Row(
          children: [
            Text("Duration: ${info.duration~/60}Min. ${info.duration%60} Sec.", style: const TextStyle(fontSize: 15),),
            IconButton(onPressed: (){setState(() {
              info.duration += 30;
            });}, icon: Icon(Icons.add)),
            IconButton(onPressed: (){setState(() {
              info.duration -= 30;
              if(info.duration<30){info.duration = 30;}
            });}, icon: Icon(Icons.remove)),
            Text(info.label),
            Switch(value: info.hot, onChanged: (value){
              setState(() {
                info.hot = value;
                info.update();
              });
            }),

          ],
        ),
      color: color_,
    );
  }
}

class TemperaturePhaseInfo{
  bool hot = false;
  int duration = 60;
  Color color = Colors.blueAccent;
  String label = "C O L D";
  String? status;

  update(){
    if(!hot){
      color = Colors.blueAccent;
      label = "C O L D";
    }
    else{
      color = Colors.redAccent;
      label = "H O T";
    }
  }
}