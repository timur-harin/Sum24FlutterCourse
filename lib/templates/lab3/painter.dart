// Your existing imports
import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  double waterIntakeLevel;
  final double incrementAmount;
  final Duration animationDuration;

  WaterProgressPainter({
    required this.waterIntakeLevel,
    this.incrementAmount = 0.1,
    this.animationDuration = const Duration(seconds: 1),
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO - Using size and waterIntakeLevel to calculate the water level
  final waterLevel = size.height * waterIntakeLevel;

    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // TODO - Draw the water level on the canvas using rectangle and size from waterLevel
      if ( (size.height - waterLevel <= size.height)) {
      canvas.drawRect(Rect.fromLTRB(0, size.height - waterLevel, size.width, size.height), paint);}
  }

  @override
  bool shouldRepaint(covariant WaterProgressPainter oldDelegate) => true;
}

class WaterPainterWidget extends StatefulWidget {
  final double waterIntakeLevel;

  const WaterPainterWidget({super.key, required this.waterIntakeLevel});

  @override
  WaterPainterState createState() => WaterPainterState();
}

class WaterPainterState extends State<WaterPainterWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaterProgressPainter(
        waterIntakeLevel: widget.waterIntakeLevel,
      ),
    );
  }
}


