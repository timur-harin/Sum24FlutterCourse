import 'package:flutter/material.dart';
import 'dart:math' as math;




class WavePainter extends CustomPainter {
  final double animationValue;
  final double waterPercentage;
  final double waveHeight;
  final Color color;
  final double shift;

  WavePainter({required this.animationValue, this.waveHeight = 20, this.waterPercentage = 1, this.color = Colors.blue, this.shift = 0});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, waterPercentage*size.height + math.sin(2*math.pi*animationValue + (0.5+shift)*math.pi)*waveHeight);

    path.cubicTo(
      size.width/3, waterPercentage*size.height + math.sin(2*math.pi*animationValue + (shift+0.5+(4/3))*math.pi)*waveHeight*3, // First control point
      size.width*(2/3), waterPercentage*size.height + math.sin(2*math.pi*animationValue + (shift+0.5+(2/3))*math.pi)*waveHeight*3, // Second control point
      size.width, waterPercentage*size.height +math.sin(2*math.pi*animationValue + (shift+0.5)*math.pi)*waveHeight, // Third control point
    );
    path.lineTo(size.width, 0);

    path.close();


    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class WaveAnimation extends StatefulWidget {
  final Duration duration;
  final double? waterPercentage;
  final double? waveHeight;
  final double? shift;
  final Color? color;

  const WaveAnimation({ super.key, required this.duration, this.waterPercentage, this.waveHeight, this.color, this.shift });
  @override
  State<WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double curWaterPercentage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.repeat();
    curWaterPercentage = widget.waterPercentage??1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(curWaterPercentage > (widget.waterPercentage??1)){
      setState(() {
        curWaterPercentage=curWaterPercentage+0.01;
      });
    }
    if(curWaterPercentage < (widget.waterPercentage??1)){
      setState(() {
        curWaterPercentage=curWaterPercentage+0.01;
      });
    }
    return AnimatedBuilder(
      
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scaleY: -1,
          child: CustomPaint(
            painter: WavePainter(animationValue: _controller.value, waterPercentage: curWaterPercentage ,waveHeight:widget.waveHeight??20, color:widget.color??Colors.blue,shift:widget.shift??0),
            child: Container(),
          ),
        );
      },
    );

  }

}




