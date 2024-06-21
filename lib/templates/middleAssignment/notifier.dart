import 'storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final pageProvider = StateProvider<int>((ref) => 0);
final timeToReloadProvider = StateProvider<bool>((ref) => false);

final userHistoryProvider = Provider<UserHistory>((ref) {
  return UserHistory();
});





final currentSessionProvider = StateProvider<ShowerSession?>((ref) {
  return null;
});