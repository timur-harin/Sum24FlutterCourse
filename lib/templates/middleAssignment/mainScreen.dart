import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/settingsScreen.dart';

class MainScreen extends ConsumerWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion', style: TextStyle(fontSize: 30.0),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Priveous sessions:", style: TextStyle(fontSize: 20),)

          ],
        ),
      ),
      backgroundColor: Colors.cyanAccent,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen())
          );
        },
        backgroundColor: Colors.greenAccent,
        label: Text("Start new session", style: TextStyle(fontSize: 15.0),),
        elevation: 0.0,
      ),
    );
  }
}