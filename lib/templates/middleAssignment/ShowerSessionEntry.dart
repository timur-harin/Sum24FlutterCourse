class ShowerSessionEntry {
  int duration;
  int realDuration;
  int intervals;
  int realIntevals;
  DateTime start;
  int rating;

  ShowerSessionEntry(this.duration, this.intervals, this.start, this.rating, this.realDuration, this.realIntevals);

  ShowerSessionEntry.fromJson(Map<String, dynamic> json)
      : duration = json['duration'],
        intervals = json['intervals'],
        start = DateTime.parse(json['start']),
        rating = json['rating'],
        realDuration  = json['realDuration'],
        realIntevals  = json['realIntervals'];

  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'intervals': intervals,
      'rating': rating,
      'start': start.toIso8601String(),
      'realDuration': realDuration,
      'realIntervals': realIntevals,
    };
  }
}
