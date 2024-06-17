import 'package:hive/hive.dart';

part 'sessionBath.g.dart';

@HiveType(typeId: 0)
class sessionBath extends HiveObject {
  @HiveField(0)
  List<String> duration;
  @HiveField(1)
  List<DateTime> timeStart;

  sessionBath({this.duration = const [], this.timeStart = const []});

  void startSession(String InDuration) {
    duration = List.from(duration)..add(InDuration);
    timeStart = List.from(timeStart)..add(DateTime.now());
  }
}
