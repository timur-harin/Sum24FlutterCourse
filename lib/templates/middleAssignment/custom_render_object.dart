import 'package:flutter/material.dart';

class TemperaturePhaseIndicator extends StatefulWidget {
  final int temperature;

  TemperaturePhaseIndicator({required this.temperature});

  @override
  _TemperaturePhaseIndicatorState createState() => _TemperaturePhaseIndicatorState();
}

class _TemperaturePhaseIndicatorState extends State<TemperaturePhaseIndicator> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
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
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.temperature > 30? Colors.red : Colors.blue,
          ),
          child: Center(
            child: Text(
              '${widget.temperature}°C',
              style: TextStyle(fontSize: 15),
            ),
          ),
        );
      },
    );
  }
}