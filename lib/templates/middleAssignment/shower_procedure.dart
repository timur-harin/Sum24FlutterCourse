class ShowerProcedure {
  double cold_duration;
  double hot_duration;

  ShowerProcedure({this.cold_duration = 0.0, this.hot_duration = 0.0});

  Map<String, dynamic> toJson() => {
    'coldDuration': cold_duration,
    'hotDuration': hot_duration,
  };

  void setColdDuration(double duration) {
    cold_duration = duration;
  }

  void setHotDuration(double duration) {
    hot_duration = duration;
  }

  double getColdDuration() {
    return cold_duration;
  }

  double getHotDuration() {
    return hot_duration;
  }

  factory ShowerProcedure.fromJson(Map<String, dynamic> json) => ShowerProcedure(
    cold_duration: json['coldDuration'] as double,
    hot_duration: json['hotDuration'] as double,
  );

  void setHotDurations(double coldDuration, double hotDuration) {
    cold_duration = coldDuration;
    hot_duration = hotDuration;
  }
}