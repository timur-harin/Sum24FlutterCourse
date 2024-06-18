import 'package:flutter/material.dart';
import 'CycleSettingsScreen.dart';

class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Contrast Shower Manager",
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          children: [
            Text(
              "History",
              style: TextStyle(
                color: Colors.black
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CycleSettingsScreen())
          );
        },
        backgroundColor: Colors.blue,

        child: const Icon(
          Icons.shower_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}