// models/models.dart
import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class ShowerSession extends HiveObject {
  @HiveField(0)
  final DateTime dateTime;

  @HiveField(1)
  final List<TemperaturePhase> phases;

  @HiveField(2)
  final int duration;

  ShowerSession(this.dateTime, this.phases, this.duration);
}

@HiveType(typeId: 1)
class TemperaturePhase extends HiveObject {
  @HiveField(0)
  final String phase;

  @HiveField(1)
  final int duration;

  TemperaturePhase(this.phase, this.duration);
}
