import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CycleTab{
  Center newCycle() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {return;},
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