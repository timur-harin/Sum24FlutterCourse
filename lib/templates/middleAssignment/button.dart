import 'package:flutter/material.dart';

Widget gradientButton({
  required String label,
  required VoidCallback onPressed,
  required List<Color> gradientColors,
}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}