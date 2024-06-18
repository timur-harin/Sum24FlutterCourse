// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart'; // Assuming the models are defined in this file

final showerSessionProvider = StateNotifierProvider<ShowerSessionNotifier, ShowerSession>((ref) => ShowerSessionNotifier());

class ShowerSessionNotifier extends StateNotifier<ShowerSession> {
  ShowerSessionNotifier() : super(ShowerSession(date: DateTime.now(), duration: Duration.zero, phases: []));

  void updateSession(ShowerSession session) {
    state = session;
  }
}

final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) => UserPreferencesNotifier());

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier() : super(UserPreferences(defaultHotDuration: const Duration(minutes: 5), defaultColdDuration: const Duration(minutes: 5)));

  void updatePreferences(UserPreferences preferences) {
    state = preferences;
  }
}

final showerHistoryProvider = StateNotifierProvider<ShowerHistoryNotifier, List<ShowerSession>>((ref) => ShowerHistoryNotifier());

class ShowerHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  ShowerHistoryNotifier() : super([]);

  void addSession(ShowerSession session) {
    state = [...state, session];
  }

  void clearHistory() {
    state = [];
  }
}