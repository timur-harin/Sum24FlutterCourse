import 'package:flutter/material.dart';

//colors
Color primary = const Color.fromRGBO(142, 108, 239,1);
Color white = const Color.fromRGBO(255, 255, 255,1);
Color white244 = const Color.fromRGBO(244, 244, 244,1);
Color red = const Color.fromRGBO(250, 54,54 ,1);
Color blue = const Color.fromARGB(255, 54, 57, 250);
Color black = const Color.fromRGBO(39, 39, 39,1);
Color dark1 = const Color.fromRGBO(29, 24, 42, 1);
Color dark2 = const Color.fromRGBO(52, 47, 63, 1);

//text size
double medium = 16;

//font weight
FontWeight w300 = FontWeight.w300;
FontWeight w400 = FontWeight.w400;
FontWeight w500 = FontWeight.w500;
FontWeight w600 = FontWeight.w600;

//padding
EdgeInsets a8 = const EdgeInsets.all(8);
EdgeInsets a16 = const EdgeInsets.all(16);
EdgeInsets l16 = const EdgeInsets.only(left: 16);
EdgeInsets r16 = const EdgeInsets.only(right: 16);
EdgeInsets lr16 = const EdgeInsets.only(left: 16,right: 16);
EdgeInsets sv15 = const EdgeInsets.symmetric(vertical: 15);
EdgeInsets tb5 = const EdgeInsets.only(top: 5, bottom: 5);
EdgeInsets lr10 = const EdgeInsets.only(right: 15, left: 10);

//textStyle light
TextStyle bf32w600 = TextStyle(color: black, fontSize: 32, fontWeight: w600);
TextStyle bf24w600 = TextStyle(color: black, fontSize: 24, fontWeight: w600);
TextStyle bf16w400 = TextStyle(color: black, fontSize: 16, fontWeight: w400);
TextStyle bf14w600 = TextStyle(color: black, fontSize: 14, fontWeight: w600);
TextStyle bf14w400 = TextStyle(color: black, fontSize: 14, fontWeight: w400);
TextStyle rf16w600 = TextStyle(color: red, fontSize: 16, fontWeight: w600);

// dark
TextStyle wf32w600 = TextStyle(color: white, fontSize: 32, fontWeight: w600);
TextStyle wf100w600 = TextStyle(color: white, fontSize: 100, fontWeight: w600);
TextStyle wf14w400 = TextStyle(color: white, fontSize: 14, fontWeight: w400);
TextStyle wf14w600 = TextStyle(color: white, fontSize: 14, fontWeight: w600);
TextStyle wf24w600 = TextStyle(color: white, fontSize: 24, fontWeight: w600);

//mainAxisAligment
MainAxisAlignment center = MainAxisAlignment.center;
MainAxisAlignment spb = MainAxisAlignment.spaceBetween;
 
Alignment centerAlign = Alignment.center;
Alignment centerLeft = Alignment.centerLeft;

//axis
Axis horizontal = Axis.horizontal;
Axis vertical = Axis.vertical;