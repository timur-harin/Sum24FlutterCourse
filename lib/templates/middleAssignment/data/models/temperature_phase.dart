
class TemperaturePhase {
  final int id;
  final int temperature;
  final int duration;

  TemperaturePhase({required this.id, required this.temperature, required this.duration});

  factory TemperaturePhase.fromJson(Map<String, dynamic> json) {
    return TemperaturePhase(
      id: json['id'],
      temperature: json['temperature'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'temperature': temperature,
      'duration': duration,
    };
  }

}