import 'package:hive_flutter/adapters.dart';

class Boxes {
  static const String history = 'history';
  static const String settings = 'settings';

  Boxes._();

  static Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox<Map>(history),
      Hive.openBox(settings),
    ]);
  }
}
