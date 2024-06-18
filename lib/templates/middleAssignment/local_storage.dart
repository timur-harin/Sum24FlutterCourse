import 'package:hive_flutter/hive_flutter.dart';
import 'models/session_model.dart';
import 'package:intl/intl.dart';



class LocalStorageService {
  LocalStorageService() {
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SessionAdapter());
    Hive.openBox("sessions");
  }

  void addSession({required String id}) {
    var sessionBox = Hive.box("sessions");
    sessionBox.put(id, Session(DateFormat("dd MMM\nyyyy").format(DateTime.now()), "123"));
  }

  Session getSession({required String id}) {
    var sessionBox = Hive.box("sessions");
    return sessionBox.get(id);
  }
}