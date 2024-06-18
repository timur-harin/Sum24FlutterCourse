import 'package:contrast_shower_app/globaL/const.dart';
import 'package:flutter/material.dart';

class NumberPicker extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final ValueChanged<int> onChanged;

  const NumberPicker({super.key, 
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_drop_up,color: white,),
          onPressed: value < maxValue ? () => onChanged(value + 1) : null,
        ),
        Text(
          value.toString().padLeft(2, '0',),
          style: wf24w600,
        ),
        IconButton(
          icon: Icon(Icons.arrow_drop_down,color: white,),
          onPressed: value > minValue ? () => onChanged(value - 1) : null,
        ),
      ],
    );
  }
}
