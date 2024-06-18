class SessionHistory {
  int time;
  double rating;
  int countOfPhases;

  SessionHistory({
    required this.countOfPhases,
    required this.time,
    required this.rating,
  });

  SessionHistory.fromJson(Map <String, dynamic> json)
  : time = json['time'],
    countOfPhases = json['countOfPhases'],
    rating = json['rating'];


  Map<String, dynamic> toJson() => {
    'time' : time,
    'countOfPhases' : countOfPhases,
    'rating' : rating,
  };
}