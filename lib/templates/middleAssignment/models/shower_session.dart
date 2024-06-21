import 'dart:convert';

class ShowerSession {
  String startTime;
  int totalDuration;
  int numbOfCycles;
  String? rate;

  ShowerSession(this.startTime, this.totalDuration, this.numbOfCycles, {this.rate});

  factory ShowerSession.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return ShowerSession(
      json['startTime'] as String,
      json['totalDuration'] as int,
      json['numbOfCycles'] as int,
      rate: json['rate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'startTime': startTime,
      'totalDuration': totalDuration,
      'numbOfCycles': numbOfCycles,
    };
    
    if (rate != null) {
      data['rate'] = rate;
    }

    return data;
  }
}