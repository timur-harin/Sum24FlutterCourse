import 'package:hive/hive.dart';

part 'sessionshistory.g.dart';

@HiveType(typeId: 1)
class Sessionshistory {
  Sessionshistory(
      {required this.historyTotalTime,
      required this.historyHotWaterDuration,
      required this.historyColdWaterDuration,
      required this.historyNumberOfCycles,
      required this.historyRating});
  @HiveField(0)
  int historyTotalTime;

  @HiveField(1)
  int historyHotWaterDuration;

  @HiveField(2)
  int historyColdWaterDuration;

  @HiveField(3)
  int historyNumberOfCycles;

  @HiveField(4)
  double historyRating;
}