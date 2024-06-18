
import 'package:flutter/material.dart';
import '../models/temperature_phase.dart';

class CustomRenderObject extends StatefulWidget {
  final TemperaturePhase? phase;

  CustomRenderObject(this.phase);

  @override
  _CustomRenderObjectState createState() => _CustomRenderObjectState();
}

class _CustomRenderObjectState extends State<CustomRenderObject>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = ColorTween(
      begin: widget.phase == TemperaturePhase.hot ? Colors.red : Colors.blue,
      end: widget.phase == TemperaturePhase.hot ? Colors.blue : Colors.red,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 200,
          width: 200,
          color: _animation.value,
        );
      },
    );
  }
}