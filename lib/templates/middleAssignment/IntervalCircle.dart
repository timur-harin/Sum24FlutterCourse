import 'package:flutter/material.dart';

class IntervalCirclePainter extends CustomPainter {
  final double sessionLength;
  final int nSegments;
  final Color coldColor;
  final Color warmColor;
  final double? progress;
  final bool? isCold;

  IntervalCirclePainter(
      {required this.sessionLength,
      required this.nSegments,
      required this.coldColor,
      required this.warmColor,
      this.progress,
      this.isCold});

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -90.0 - 360 * (progress ?? 0); // Start at the top
    double degreeLen = (sessionLength / nSegments) / sessionLength;
    double gap = size.width / 20;

    for (int i = 0; i < nSegments; i++) {
      final paint = Paint()
        ..color = i % 2 == 1 ? warmColor : coldColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;
      final sweepAngle = degreeLen * 360.0;

      // canvas.drawArc(
      //   Rect.fromCircle(
      //       center: size.center(Offset.zero), radius: size.width / 2),
      //   radians(startAngle + 3),
      //   radians(sweepAngle - 3),
      //   false,
      //   paint,
      // );

      final rect = Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2);
      final path = Path()
        ..arcTo(
            rect, radians(startAngle + gap), radians(sweepAngle - gap), false);
      canvas.drawPath(path, paint);

      startAngle += sweepAngle;
    }
  }

  double radians(double degrees) => degrees * (3.141592653589793 / 180.0);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class IntervalCircle extends StatelessWidget {
  final double sessionLength;
  final int nIntervals;

  IntervalCircle(this.nIntervals, this.sessionLength);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final coldColor = Color.fromARGB(255, 00, 105, 137);
    final warmColor = Color.fromARGB(255, 232, 141, 103);

    return new SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: IntervalCirclePainter(
                sessionLength: this.sessionLength, 
                nSegments: this.nIntervals, 
                coldColor: coldColor, 
                warmColor: warmColor),
              child: Container(),
            ),
            Text.rich(
              TextSpan(children: [
                WidgetSpan(
                    child: Icon(Icons.ac_unit, size: 40, color: coldColor)),
                WidgetSpan(
                    child: Icon(Icons.local_fire_department,
                        size: 40, color: warmColor))
              ]),
            )
          ],
        ));
  }
}
