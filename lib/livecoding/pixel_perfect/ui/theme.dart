import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(13, 3, 27, 1.0);

final ThemeData theme = ThemeData(
  canvasColor: primaryColor,
  scaffoldBackgroundColor:  primaryColor,
  primaryColor: primaryColor,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Coves',
      fontWeight: FontWeight.w700,
      fontSize: 64,
      color: Colors.white
    ),
    titleMedium: TextStyle(
        fontFamily: 'Coves', fontWeight: FontWeight.w700, fontSize: 20),
    titleSmall: TextStyle(
      fontFamily: 'Coves',
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  ),
);
