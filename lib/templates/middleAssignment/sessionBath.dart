import 'package:hive/hive.dart';

part 'sessionBath.g.dart';

@HiveType(typeId: 0)
class sessionBath extends HiveObject {
  @HiveField(0)
  List<String> duration;
  @HiveField(1)
  List<DateTime> timeStart;
  @HiveField(2)
  List<String> phase_duration;

  sessionBath(
      {this.duration = const [],
      this.timeStart = const [],
      this.phase_duration = const []});

  void startSession(String InDuration, String InPhase_duration) {
    duration = List.from(duration)..add(InDuration);
    timeStart = List.from(timeStart)..add(DateTime.now());
    phase_duration = List.from(phase_duration)..add(InPhase_duration);
  }
}
