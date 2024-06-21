import 'package:flutter/material.dart';

class ShowerSession {
  final String level;
  final String totalTime;
  final int numbOfCycles;
  String? rate;
  final String startTime;

  ShowerSession({
    required this.level,
    required this.totalTime,
    required this.numbOfCycles,
    required this.startTime,
    this.rate,
  });
  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      level: json['level'] as String,
      totalTime: json['totalTime'] as String,
      numbOfCycles: json['numbOfCycles'] as int,
      startTime: json['startTime'] as String,
      rate: json['rate'] as String?, 
    );
  }
}
