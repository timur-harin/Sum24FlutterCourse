import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/showerScreen.dart';
import 'package:education/templates/middleAssignment/temperaturePhase.dart';
import 'package:education/templates/middleAssignment/showerSession.dart';

class SettingsScreen extends ConsumerWidget{

  SettingsScreen({super.key}){
    DataHelper.infoList = [];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    List<Widget> wlist = widgetList.wList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion', style: TextStyle(fontSize: 30.0),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: ShowerSessionWidget()
      ),
      //backgroundColor: Colors.cyanAccent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShowerScreen())
          );
        },
        backgroundColor: Colors.greenAccent,
        label: const Text("Start"),
      ),
    );
  }
}
class widgetList{
  static List<Widget> wList = [
  Text("Set up your session", style: TextStyle(fontSize: 20.0),),
  TemperatureWidget(),
  TemperatureWidget(),
  IconButton(onPressed: (){wList.add(TemperatureWidget());}, icon: Icon(Icons.add))
  ];
}
