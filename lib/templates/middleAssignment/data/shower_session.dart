import 'package:flutter/material.dart';

class ShowerSession {
  final String name;
  final String level;
  final DateTime startTime;
  final DateTime? endTime;
  ShowerSession(
      {required this.name,
      required this.level,
      required this.startTime,
      this.endTime});
}



