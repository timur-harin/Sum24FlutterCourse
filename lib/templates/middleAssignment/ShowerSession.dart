class ShowerSession {
  final String startPhase;
  final int repetitions;
  final int completedRepetitions;
  final int totalDuration;
  final DateTime timestamp;
  final int rating;

  ShowerSession({
    required this.startPhase,
    required this.repetitions,
    required this.completedRepetitions,
    required this.totalDuration,
    required this.timestamp,
    this.rating = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'startPhase': startPhase,
      'repetitions': repetitions,
      'completedRepetitions': completedRepetitions,
      'totalDuration': totalDuration,
      'timestamp': timestamp.toIso8601String(),
      'rating': rating,
    };
  }

  factory ShowerSession.fromMap(Map<String, dynamic> map) {
    return ShowerSession(
      startPhase: map['startPhase'],
      repetitions: map['repetitions'],
      completedRepetitions: map['completedRepetitions'],
      totalDuration: map['totalDuration'],
      timestamp: DateTime.parse(map['timestamp']),
      rating: map['rating'],
    );
  }
}
