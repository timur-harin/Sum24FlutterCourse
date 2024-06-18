import 'package:flutter/material.dart';

class TemperatureWidget extends StatefulWidget{
  const TemperatureWidget({super.key});

  @override
  State<TemperatureWidget> createState() => TemperaturePhase();
}

class TemperaturePhase extends State<TemperatureWidget>{
  bool hot = false;
  String temperature = "cold";
  int duration = 60;
  TemperaturePhase({this.hot=false, this.duration=60});
  @override
  Widget build(BuildContext context) {
    Color color_ = Colors.blueAccent;
    if(hot){color_ = Colors.red;}
    return Container(
        child: Row(
          children: [
            Text("Duration: ${duration~/60}:${duration%60}", style: const TextStyle(fontSize: 15),),
            IconButton(onPressed: (){setState(() {
              duration += 30;
            });}, icon: Icon(Icons.add)),
            IconButton(onPressed: (){setState(() {
              duration -= 30;
              if(duration<30){duration = 30;}
            });}, icon: Icon(Icons.remove)),
            Text(temperature),
            Switch(value: hot, onChanged: (value){
              setState(() {
                hot = value;
                if(hot){temperature = "hot";}
                else{temperature = "cold";}
              });
            }),
            TextButton(
                onPressed: (){setState(() {

                });},
                child: Text("Remove", style: TextStyle(color: Colors.black),),

            )
          ],
        ),
      color: color_,
    );
  }
}