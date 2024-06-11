import 'package:flutter/material.dart';
import 'painter.dart';

class HydrationWidget extends StatefulWidget {
  final double waterIntake;

  const HydrationWidget({super.key, required this.waterIntake});

  @override
  HydrationWidgetState createState() => HydrationWidgetState();
}

class HydrationWidgetState extends State<HydrationWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height - 250,
      child: WaterPainterWidget(waterIntakeLevel: widget.waterIntake / 2000), // Assuming 2000 ml is the full capacity
    );
  }
}
