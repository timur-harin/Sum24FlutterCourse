import 'package:education/templates/middleAssignment/data/session.dart';

class HistoryItem {
  final DateTime timestamp;
  final int cycles;
  final Thermostat lastTemp;
  final Duration totalTime;

  HistoryItem({
    required this.timestamp,
    required this.cycles,
    required this.lastTemp,
    required this.totalTime,
  });
  factory HistoryItem.fromDbItem(Map item) => HistoryItem(
        timestamp: DateTime.fromMillisecondsSinceEpoch(item['timestamp'] ?? 0),
        cycles: item['cycles'] ?? 0,
        lastTemp: Thermostat.parse(item['last_temp'])!,
        totalTime: Duration(seconds: item['total_time'] ?? 0),
      );

  static Map toDbItem(ShowerSession session) => {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'cycles': session.cycles,
        'last_temp': session.thermostat.toString(),
        'total_time': session.totalTime.inSeconds,
      };
}
