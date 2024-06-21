import 'package:flutter/material.dart';

class SessionInfo {
  late int time; 
  late Color color;
  late int realTime = -1;

  SessionInfo({required this.time, required this.color, required this.realTime});

  factory SessionInfo.initial() {
    return SessionInfo(
      time: 0,
      color: Colors.white,
      realTime: -1,
    );
  }
  SessionInfo copyWith({
    int? time,
    Color? color,
    int? realTime,
  }) {
    return SessionInfo(
      time: time ?? this.time,
      color: color ?? this.color,
      realTime: realTime ?? this.realTime,
    );
  }

  // Method to convert a JSON map to a Sessioninfo object
  factory SessionInfo.fromJson(Map<String, dynamic> json) {
    return SessionInfo(
      time: json['time'],
      color: Color(json['color']),
      realTime: json['realTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'color': color.value,
      'realTime': realTime,
    };
  }

  // Static method to convert a JSON list to a list of Sessioninfo objects
  static List<SessionInfo> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SessionInfo.fromJson(json)).toList();
  }
}
