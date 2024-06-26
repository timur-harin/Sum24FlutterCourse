import 'sessionBath.dart';
import 'package:hive/hive.dart';

class LocalStorageService {
  static const session = 'session_info';

  LocalStorageService() {
    Hive.registerAdapter(sessionBathAdapter());
  }

  Future<void> saveSession(sessionBath intake) async {
    var Box = await Hive.openBox<sessionBath>('box_for_sessions');
    Box.put(session, intake);
  }

  Future<sessionBath> getSession() async {
    var Box = await Hive.openBox<sessionBath>('box_for_sessions');
    return Box.get(session) ?? sessionBath();
  }
}
