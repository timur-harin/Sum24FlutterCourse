import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riverpod_model.dart';

final riverpod = ChangeNotifierProvider<RiverpodModel>((ref) {
  return RiverpodModel(duration: 0, minTemp: 0, maxTemp: 0);
});