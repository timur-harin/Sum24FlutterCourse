import 'package:hive_flutter/hive_flutter.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class Session {
  @HiveField(0)
  DateTime startTime;
  @HiveField(1)
  DateTime endTime;
  @HiveField(2)
  int cycles;
  @HiveField(3)
  int? rating;

  Session(
    this.startTime,
    this.endTime,
    this.cycles,
    {this.rating}
  );

  String getDuration() {
    return '${startTime.day}.${startTime.month}.${startTime.year} ${startTime.hour}:${startTime.minute}:${startTime.second} - ${endTime.hour}:${endTime.minute}:${endTime.second}';
  }

  void setRating(int value) {
    rating = value;
  }
}