class Session {
  final String color;
  final SessionType feedback;
  final int duration;
  final int numOfCycles;

  Session(
    this.color,
    this.feedback,
    this.duration,
    this.numOfCycles,
  );

  Session.fromJson(Map<String, dynamic> json)
: color = json['color'],
  feedback = SessionType.values[json['feedback']],
  duration = json['duration'],
  numOfCycles = json['numOfCycles'];
}

enum SessionType {
  Excellent,
  Good,
  Neutral,
  Bad,
}