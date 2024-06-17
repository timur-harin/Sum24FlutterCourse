import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressBar extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;
  final Duration totalDuration;

  CircleProgressBar({
    Key? key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.value,
    required this.totalDuration,
  }) : super(key: key);

  @override
  CircleProgressBarState createState() => CircleProgressBarState();
}

class CircleProgressBarPainter extends CustomPainter {
  final Color backgroundColor;
  final Color foregroundColor;
  final double percentage;
  final Duration totalDuration;

  CircleProgressBarPainter({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.percentage,
    required this.totalDuration,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    Paint foregroundPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);
    double sweepAngle = 2 * pi * percentage;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        sweepAngle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(CircleProgressBarPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundColor != foregroundColor;
  }
}

class CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<double> valueTween;
  late ColorTween foregroundColorTween; // Define foregroundColorTween here
  late Animation<double> curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.totalDuration,
      vsync: this,
    );
    valueTween = Tween<double>(
      begin: 0,
      end: widget.value,
    );
    foregroundColorTween = ColorTween(
      begin: widget.foregroundColor,
      end: widget.foregroundColor,
    ); // Initialize foregroundColorTween here
    curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      double beginValue =
          valueTween?.evaluate(_controller) ?? oldWidget?.value ?? 0;
      valueTween = Tween<double>(
        begin: beginValue,
        end: widget.value ?? 1,
      );
      foregroundColorTween = ColorTween(
        begin: oldWidget.foregroundColor,
        end: widget.foregroundColor,
      ); // Update foregroundColorTween here
      _controller
        ..value = 0
        ..forward();
    }
  }

  void pauseAnimation() {
    if (_controller.isAnimating) {
      _controller.stop(canceled: true);
    }
  }

  void resumeAnimation() {
    if (!_controller.isAnimating) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor;
    final foregroundColor = widget.foregroundColor;
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
        animation: curve,
        child: Container(),
        builder: (context, child) {
          final foregroundColor =
              foregroundColorTween?.evaluate(curve) ?? widget.foregroundColor;

          return CustomPaint(
            foregroundPainter: CircleProgressBarPainter(
              backgroundColor: widget.backgroundColor,
              foregroundColor: foregroundColor,
              percentage: valueTween.evaluate(curve),
              totalDuration: widget.totalDuration,
            ),
            child: child,
          );
        },
      ),
    );
  }
}
