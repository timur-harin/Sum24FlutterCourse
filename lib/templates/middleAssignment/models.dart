import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ShowerSession extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final List<TemperaturePhase> phases;

  ShowerSession({required this.date, required this.phases});
}

@HiveType(typeId: 1)
class TemperaturePhase extends HiveObject {
  @HiveField(0)
  final String type; // 'hot' or 'cold'

  @HiveField(1)
  final int duration; // in seconds

  TemperaturePhase({required this.type, required this.duration});
}

@HiveType(typeId: 2)
class UserPreferences extends HiveObject {
  @HiveField(0)
  final int hotDuration;

  @HiveField(1)
  final int coldDuration;

  UserPreferences({required this.hotDuration, required this.coldDuration});
}