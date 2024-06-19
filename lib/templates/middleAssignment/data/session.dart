class Session {
  final int temperature;
  final SessionType type;
  final DateTime startTime;
  final DateTime? endTime;

  Session(this.temperature, this.type, this.startTime, {this.endTime});
}

enum SessionType {
  Finished,
  Stopped
}