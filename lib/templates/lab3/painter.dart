// Your existing imports
import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeLevel;

  WaterProgressPainter({
    required this.waterIntakeLevel,
  });

  @override
  @override
void paint(Canvas canvas, Size size) {
  // Рассчитываем высоту прямоугольника, которая будет равна высоте виджета
  final height = size.height;
  // Рассчитываем ширину прямоугольника, которая будет равна половине ширины виджета
  final width = size.width;
  // Вычисляем координаты левого и верхнего края прямоугольника
  final left = size.width * 0.25; // Начинаем с центра, смещаясь на четверть ширины виджета вправо
  final top = 0.0; // Начинаем с верха виджета
  // Вычисляем координаты правого и нижнего края прямоугольника
  final right = left + width;
  final bottom = height;

  final paint = Paint()
   ..color = Colors.blueAccent.withOpacity(0.5)
   ..style = PaintingStyle.fill;

  // Рисуем прямоугольник, представляющий уровень воды
  canvas.drawRect(Rect.fromLTRB(0, height - waterIntakeLevel, width, height), paint);
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
