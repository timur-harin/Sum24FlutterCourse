import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final riverpodHotTimer = StateProvider<Duration>((ref) {
  return Duration(hours: 0, minutes: 0, seconds: 0);
});

final riverpodColdTimer = StateProvider<Duration>((ref) {
  return Duration(hours: 0, minutes: 0, seconds: 0);
});

final riverpodFullTimer = StateProvider<Duration>((ref) {
  return Duration(hours: 0, minutes: 0, seconds: 0);
});
