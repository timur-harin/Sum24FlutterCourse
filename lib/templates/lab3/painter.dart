// Your existing imports
import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeLevel;

  WaterProgressPainter({
    required this.waterIntakeLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final waterLevel = waterIntakeLevel;
    // TODO - Using size and waterIntakeLevel to calculate the water level
    // final waterLevel =

    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    
    final left = 0.0;
    final top = size.height - size.height*waterLevel/2000;
    final right = size.width;
    final bottom = size.height;

    canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);
    
    
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
