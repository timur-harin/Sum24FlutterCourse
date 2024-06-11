// Your existing imports
import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeLevel;

  WaterProgressPainter({
    required this.waterIntakeLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO - Using size and waterIntakeLevel to calculate the water level
    // final waterLevel =

    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // TODO - Draw the water level on the canvas using rectangle and size from waterLevel
    // canvas.drawRect(
    //   Rect.fromLTRB(left, top, right, bottom)
    //   paint,
    // );
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
