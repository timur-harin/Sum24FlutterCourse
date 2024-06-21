import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final hotShowerPhaseProvider = StateProvider<double>((ref) => 30);
final coldShowerPhaseProvider = StateProvider<double>((ref) => 30);
final phasesAmountProvider = StateProvider<double>((ref) => 2);
final startHotShowerProvider = StateProvider<bool>((ref) => true);

final backgroundColorProvider = StateProvider<Color>((ref) => Colors.orange);
final timeSpentProvider = StateProvider<int>((ref) => 0);

final ratingProvider = StateProvider<int>((ref) => 1);
