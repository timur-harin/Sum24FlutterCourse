import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerScreen extends ConsumerWidget{
  const ShowerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion', style: TextStyle(fontSize: 30.0),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Phases left: 6", style: TextStyle(fontSize: 25),),
            Text("COLD!", style: TextStyle(fontSize: 25))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.arrow_circle_right), label: "next phase"),
          BottomNavigationBarItem(icon: Icon(Icons.pause), label: "pause"),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: "finish")
        ],
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}