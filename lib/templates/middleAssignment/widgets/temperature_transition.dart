import 'package:flutter/material.dart';

class TemperatureTransition extends StatelessWidget {
  final String currentPhase;

  TemperatureTransition(this.currentPhase);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      color: currentPhase == 'Hot' ? Colors.red : Colors.blue,
      child: Center(
        child: Text(
          currentPhase,
          style: TextStyle(fontSize: 48, color: Colors.white),
        ),
      ),
    );
  }
}
