import 'package:flutter_riverpod/flutter_riverpod.dart';

final cyclesProvider = StateProvider<double>((ref) => 3);
final intervalProvider = StateProvider<double>((ref) => 15);