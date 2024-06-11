import 'package:education/templates/lab3/painter.dart';
import 'package:flutter/material.dart';

class HydrationWidget extends StatefulWidget {
  final double waterIntakeLevel;

  const HydrationWidget({super.key, required this.waterIntakeLevel});

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
      child: WaterPainterWidget(waterIntakeLevel: widget.waterIntakeLevel),
    );
  }
}