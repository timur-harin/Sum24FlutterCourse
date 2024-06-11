// Your existing imports
import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeLevel;
  final double INCREASE_RATE = 0.1;

  WaterProgressPainter({
    required this.waterIntakeLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO - Using size and waterIntakeLevel to calculate the water level
    final waterLevel = (1 - waterIntakeLevel) * size.height;

    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // TODO - Draw the water level on the canvas using rectangle and size from waterLevel
    final rect = Rect.fromLTRB(0, waterLevel, size.width, size.height);
    canvas.drawRect(rect, paint);
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
