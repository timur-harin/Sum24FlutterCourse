import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class Data {
  Data({
    required this.hotShowerTime,
    required this.coldShowerTime,
    required this.totalTime,
    required this.totalPhases,
    required this.rating,
  });

  @HiveField(0)
  int hotShowerTime;

  @HiveField(1)
  int coldShowerTime;

  @HiveField(2)
  int totalTime;

  @HiveField(3)
  int totalPhases;

  @HiveField(4)
  int rating;
}
