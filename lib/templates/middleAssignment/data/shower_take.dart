import 'dart:convert';

class ShowerTake {
  final String name;
  final int duration;
  final int cycles;
  final DateTime startTime;
  final DateTime? endTime;

  ShowerTake(this.name, this.duration, this.cycles, this.startTime, {this.endTime});

  static Map<String, dynamic> toMap(ShowerTake shower_take) {
    return <String, dynamic>{
      'name': shower_take.name,
      'duration': shower_take.duration,
      'cycles': shower_take.cycles,
      'startTime': shower_take.startTime.toIso8601String(),
      'endTime': shower_take.endTime?.toIso8601String(),
    };
  }

  factory ShowerTake.fromJson(Map<String, dynamic> jsonData) {
    return ShowerTake(
      jsonData['name'] as String,
      jsonData['duration'] as int,
      jsonData['cycles'] as int,
      DateTime.parse(jsonData['startTime'] as String),
      endTime: jsonData['endTime'] != null
          ? DateTime.parse(jsonData['endTime'] as String)
          : null,
    );
  }

  static String encode(List<ShowerTake> showerTakes) => json.encode(
        showerTakes
            .map<Map<String, dynamic>>((showerTake) => ShowerTake.toMap(showerTake))
            .toList(),
      );

  static List<ShowerTake> decode(String showerTakes) =>
      (json.decode(showerTakes) as List<dynamic>)
          .map<ShowerTake>((item) => ShowerTake.fromJson(item))
          .toList();
}