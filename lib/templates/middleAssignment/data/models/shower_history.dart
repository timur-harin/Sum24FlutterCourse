import "package:education/templates/middleAssignment/providers/notifier.dart";

class ShowerSession {
  final int _id;
  final String _date;
  final List<TemperaturePhase> _temperaturePhases;

  int get id => _id;

  String get date => _date;

  List<TemperaturePhase> get temperaturePhases => _temperaturePhases;

  ShowerSession({required int id, required String date, required List<TemperaturePhase> temperaturePhases})
      : _temperaturePhases = temperaturePhases,
        _date = date,
        _id = id;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'date': _date,
      'temperaturePhases': _temperaturePhases.map((phase) => phase.toJson()).toList(),
    };
  }

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      id: json['id'],
      date: json['date'],
      temperaturePhases: (json['temperaturePhases'] as List)
          .map((phaseJson) => TemperaturePhase.fromJson(phaseJson))
          .toList(),
    );
  }
}

class TemperaturePhase {
  final int _id;
  final String _temperature;
  final int _duration;

  int get id => _id;

  String get temperature => _temperature;

  int get duration => _duration;

  TemperaturePhase({required int id, required String temperature, required int duration})
      : _duration = duration,
        _temperature = temperature,
        _id = id;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'temperature': _temperature,
      'duration': _duration,
    };
  }

  factory TemperaturePhase.fromJson(Map<String, dynamic> json) {
    return TemperaturePhase(
      id: json['id'],
      temperature: json['temperature'],
      duration: json['duration'],
    );
  }
}
