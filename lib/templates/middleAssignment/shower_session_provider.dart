import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ShowerSession {
  final int duration;
  final String date;
  final double rating;

  ShowerSession({
    required this.duration,
    required this.date,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'duration': duration,
      'date': date,
      'rating': rating,
    };
  }

  static ShowerSession fromMap(Map<String, dynamic> map) {
    return ShowerSession(
      duration: map['duration'],
      date: map['date'],
      rating: map['rating'],
    );
  }
}

final showerSessionProvider = StateNotifierProvider<ShowerSessionNotifier, List<ShowerSession>>((ref) {
  return ShowerSessionNotifier();
});

class ShowerSessionNotifier extends StateNotifier<List<ShowerSession>> {
  ShowerSessionNotifier() : super([]) {
    _loadSessions();
  }

  void _loadSessions() async {
    final box = await Hive.openBox('sessions');
    final sessions = box.values.map((e) => ShowerSession.fromMap(e)).toList();
    state = sessions;
  }

  void addSession(ShowerSession session) async {
    final box = await Hive.openBox('sessions');
    await box.add(session.toMap());
    state = [...state, session];
  }
}
