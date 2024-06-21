import 'package:flutter/material.dart';


class ColoredLinePainter extends CustomPainter {
  final int numberOfSegments;
  final bool startWithRed;

  ColoredLinePainter({required this.numberOfSegments, required this.startWithRed});

  @override
  void paint(Canvas canvas, Size size) {
    final segmentWidth = size.width / numberOfSegments;
    final paint = Paint()..strokeWidth = 5;

    for (int i = 0; i < numberOfSegments; i++) {
      final color = (startWithRed? !i.isEven:i.isEven) ? Colors.blue : Colors.red;
      paint.color = color;
      final startX = i * segmentWidth;
      final endX = startX + segmentWidth;
      canvas.drawLine(Offset(startX, size.height / 2), Offset(endX, size.height / 2), paint);
    }
  }

  @override
  bool shouldRepaint(ColoredLinePainter oldDelegate) {
    return oldDelegate.numberOfSegments != numberOfSegments || oldDelegate.startWithRed != startWithRed;
  }
}