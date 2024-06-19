import 'package:flutter_riverpod/flutter_riverpod.dart';

final hotShowerPhaseProvider = StateProvider<double>((ref) => 0);
final coldShowerPhaseProvider = StateProvider<double>((ref) => 0);
final phasesAmountProvider = StateProvider<double>((ref) => 0);
final startHotShowerProvider = StateProvider<bool>((ref) => true);
