import 'package:contrast_shower_app/globaL/const.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String text;
  Color textColor;
  double text_size;
  FontWeight text_weight;
  Color color;
  Color borderColor;
  VoidCallback onTap;
  
  MyButton({
    super.key, 
    required this.text, 
    required this.textColor, 
    required this.text_size, 
    required this.text_weight, 
    required this.color, 
    required this.borderColor, 
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: sv15,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: Center(
          child: Text(
            text, 
            style: TextStyle(
              color:  textColor, 
              fontSize: text_size, 
              fontWeight: text_weight
                    ),
                  ),
        ),
      ),
    );
  }
}