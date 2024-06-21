import 'package:flutter/material.dart';

class AnimatedShowerSessionWidget extends StatefulWidget {
  const AnimatedShowerSessionWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedShowerSessionWidget();
}

class _AnimatedShowerSessionWidget extends State<AnimatedShowerSessionWidget> {
  Color _colorStart = Colors.blue;
  Color _colorEnd = Colors.red;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // curve: ,
      duration: const Duration(seconds: 2),
      onEnd: () {
        setState(() {
          final c = _colorStart;
          _colorStart = _colorEnd;
          _colorEnd = c;
        });
      },
      decoration: BoxDecoration(
        color: _colorStart
      ),
    );
  }
}
