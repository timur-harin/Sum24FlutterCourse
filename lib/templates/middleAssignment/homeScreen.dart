import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'NewCycleScreen.dart';

class HomeScreen extends ConsumerWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: const Icon(
          Icons.shower_outlined,
          color: Colors.cyanAccent,
        ),
        title: const Text(
          "Shower Cycles",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: ,
                child: Text(
                  "Start new shower cycle"
                ))
          ],
        ),
      ),
    );
  }
  
  void buildNewCycleScreen() {
    NewCycleScreen().build(context, ref)
  }

}