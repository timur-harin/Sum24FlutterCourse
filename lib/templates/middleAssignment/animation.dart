import 'package:flutter/material.dart';

class TemperatureTransitionWidget extends StatefulWidget {
  final bool isHot;

  const TemperatureTransitionWidget({super.key, required this.isHot});

  @override
  _TemperatureTransitionWidgetState createState() =>
      _TemperatureTransitionWidgetState();
}

class _TemperatureTransitionWidgetState
    extends State<TemperatureTransitionWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        color: widget.isHot ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 100,
      height: 100,
    );
  }
}