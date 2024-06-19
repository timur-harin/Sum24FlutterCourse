class Session {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final int? cycles;
  final int? rating;

  const Session({
    required this.id,
    required this.startTime,
    this.endTime,
    this.cycles,
    this.rating,
  });
}