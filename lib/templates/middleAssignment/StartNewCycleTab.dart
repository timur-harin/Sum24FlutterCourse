import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CycleSettingsScreen.dart';

class CycleTab extends StatelessWidget{
  const CycleTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CycleSettingsScreen())
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shadowColor: Colors.cyan,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                )
            ),
            child: const Text(
              "Start new cycle",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}