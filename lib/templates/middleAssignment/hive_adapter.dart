import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ShowerSession extends HiveObject {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final int hotDuration;
  @HiveField(2)
  final int coldDuration;
  @HiveField(3)
  final int totalDuration;

  ShowerSession(this.date, this.hotDuration, this.coldDuration, this.totalDuration);
}
