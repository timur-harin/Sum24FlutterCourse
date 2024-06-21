import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

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
    return '${DateFormat.MMMd().format(startTime)}  ${DateFormat('hh:mm:ss').format(startTime)} - ${DateFormat(' hh:mm:ss').format(endTime)}';
  }

  void setRating(int value) {
    rating = value;
  }
}