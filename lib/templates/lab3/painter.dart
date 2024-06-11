import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeLevel;

  WaterProgressPainter({
    required this.waterIntakeLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final waterLevel = size.height * (1 - waterIntakeLevel / 2.0); // Assuming 2 liters is full

    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, waterLevel, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant WaterProgressPainter oldDelegate) => true;
}

class WaterPainterWidget extends StatelessWidget {
  final double waterIntakeLevel;

  const WaterPainterWidget({super.key, required this.waterIntakeLevel});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaterProgressPainter(
        waterIntakeLevel: waterIntakeLevel,
      ),
    );
  }
}
