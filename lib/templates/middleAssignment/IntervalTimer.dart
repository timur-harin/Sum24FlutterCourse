import 'package:flutter/material.dart';

import 'IntervalCircle.dart';

class IntervalTimer extends StatelessWidget {
  final double sessionLength;
  final int nIntervals;
  final double progress;
  final bool isCold;

  IntervalTimer(
      this.nIntervals, this.sessionLength, this.progress, this.isCold);

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
                  coldColor: isCold ? coldColor : coldColor.withAlpha(128),
                  warmColor: isCold ? warmColor.withAlpha(128) : warmColor,
                  progress: progress,
                  isCold: isCold),
              child: Container(),
            ),
            Icon(isCold ? Icons.ac_unit : Icons.local_fire_department, size: 90, color: isCold ? coldColor : warmColor),
          ],
        ));
  }
}
