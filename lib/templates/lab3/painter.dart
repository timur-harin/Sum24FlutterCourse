// Your existing imports
import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeRatio;

  WaterProgressPainter({
    required this.waterIntakeRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final waterLevel = size.height * (1.0 - waterIntakeRatio);

    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(
          size.topLeft(const Offset(0, 0)).dx,
          size.topLeft(Offset(0, waterLevel)).dy,
          size.bottomRight(const Offset(0, 0)).dx,
          size.bottomRight(const Offset(0, 0)).dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant WaterProgressPainter oldDelegate) => true;
}

class WaterPainterWidget extends StatefulWidget {
  final double waterIntakeRatio;

  const WaterPainterWidget({super.key, required this.waterIntakeRatio});

  @override
  WaterPainterState createState() => WaterPainterState();
}

class WaterPainterState extends State<WaterPainterWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaterProgressPainter(
        waterIntakeRatio: widget.waterIntakeRatio,
      ),
    );
  }
}
