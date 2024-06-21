import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const double paddingSize = 16;
const double smallPaddingSize = 8;
const double tinyPaddingSize = 6;
const double iconSize = 30;
const double fonySize = 20;

const double borderRadius = 20;

const double smallIconSize = 16;

const TextStyle headingStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 30);

const TextStyle subHeadingStyle =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 18);

const TextStyle buttonTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: Color.fromARGB(255, 27, 26, 26));

const TextStyle bodyTextStyle =
    TextStyle(fontSize: 20, color: Color.fromARGB(255, 19, 18, 18));
const TextStyle descriptionTextStyle = TextStyle(
    fontSize: 18,
    color: Color.fromARGB(255, 16, 16, 16),
    fontWeight: FontWeight.w100);
const TextStyle smallHeadingTextStyle = TextStyle(
    fontSize: 14,
    color: Color.fromARGB(255, 16, 16, 16),
    fontWeight: FontWeight.bold);

List<String> levelList = ["Easy", "Medium", "Hard"];

List<Color> levelColors = [
  const Color(0xFF5BFF62),
  const Color(0xFFF39629),
  const Color(0xFFDF0029)
];
List<Color> bgLevelColors = [
  const Color(0x705BFF62),
  const Color(0x70F39629),
  const Color(0x70DF0029),
];

const Color bgColor = const Color(0xFFD0E2EE);

const Color buttonColor = Color.fromARGB(151, 94, 103, 132);
const Color buttonBorderColor = Color(0xFF5F819A);

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFFC4DBEB),
  shape: RoundedRectangleBorder(
    side: const BorderSide(color: buttonBorderColor, width: 1),
    borderRadius: BorderRadius.circular(borderRadius),
  ),
);

ButtonStyle blackButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFFC4DBEB),
  shape: RoundedRectangleBorder(
    side: const BorderSide(color: Color.fromARGB(255, 27, 26, 26), width: 1),
    borderRadius: BorderRadius.circular(borderRadius),
  ),
);
