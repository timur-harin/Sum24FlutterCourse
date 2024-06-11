// Your existing imports
import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeLevel;

  WaterProgressPainter({
    required this.waterIntakeLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double maxWaterIntake = 12;
    double waterHeight = (waterIntakeLevel / maxWaterIntake) * size.height;

    
    double left = 0;
    double top = size.height - waterHeight; // Start from the bottom to fill upwards

    // Define the right position of the rectangle (full width)
    double right = size.width;

    
    final paint = Paint()
     ..color = Colors.blueAccent.withOpacity(0.5)
     ..style = PaintingStyle.fill;

    
    canvas.drawRect(
      Rect.fromLTWH(left, top, right - left, waterHeight),
      paint,
    );
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
