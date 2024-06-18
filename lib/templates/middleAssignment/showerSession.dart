import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/temperaturePhase.dart';

class ShowerSessionWidget extends StatefulWidget{
  const ShowerSessionWidget({super.key});
  
  @override
  State<ShowerSessionWidget> createState() => ShowerSession();
}
class ShowerSession extends State<ShowerSessionWidget>{
  static List<Widget> temperatureList = [
    TemperatureWidget(),
    TemperatureWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text("Set up your session", style: TextStyle(fontSize: 20.0),),
        Column(children: temperatureList,),
        IconButton(onPressed: (){setState(() {
          temperatureList.add(TemperatureWidget());
        });},
            icon: Icon(Icons.add))
      ],
    );
  }
  
}