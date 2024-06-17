class SessionHistory {
  int time;
  double rating;

  SessionHistory({
    required this.time,
    required this.rating,
  });

  SessionHistory.fromJson(Map <String, dynamic> json)
  : time = json['time'],
    rating = json['rating'];


  Map<String, dynamic> toJson() => {
    'time' : time,
    'rating' : rating,
  };
}