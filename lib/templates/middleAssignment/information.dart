class SessionInformation {
  int duration;
  int minTemp;
  int maxTemp;
  SessionInformation({required this.duration, required this.minTemp, required this.maxTemp});

  SessionInformation.fromJson(Map<String, dynamic> json)
  :  duration = json['duration'],
    minTemp = json['minTemp'],
    maxTemp = json['maxTemp'];

  Map<String, dynamic> toJson() => {
    'duration': duration,
    'minTemp': minTemp,
    'maxTemp': maxTemp,
  };

}