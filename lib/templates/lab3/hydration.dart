import 'package:education/templates/lab3/painter.dart';
import 'package:flutter/material.dart';

class HydrationWidget extends StatefulWidget {
  final double waterIntakeRatio;

  const HydrationWidget({super.key, required this.waterIntakeRatio});

  @override
  HydrationWidgetState createState() => HydrationWidgetState();
}

class HydrationWidgetState extends State<HydrationWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height - 200,
      child: WaterPainterWidget(waterIntakeRatio: widget.waterIntakeRatio),
    );
  }
}
