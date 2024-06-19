import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()) );
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0x2D3037FF),
        textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
      ),
      
      home: const HomeScreen(),
    );
  }
}

class ShowerSession {
  final DateTime dateTime;
  final int duration;
  final String feedback;

  ShowerSession({
    required this.dateTime,
    required this.duration,
    required this.feedback,
  });

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime.toIso8601String(),
        'duration': duration,
        'feedback': feedback,
      };

  factory ShowerSession.fromJson(Map<String, dynamic> json) =>  ShowerSession(
    dateTime: DateTime.parse(json['dateTime']),
    duration: json['duration'],
    feedback: json['feedback'],
  );
}