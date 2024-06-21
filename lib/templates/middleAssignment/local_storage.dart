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
    await Hive.openBox("sessions");
    // await Hive.box('sessions').clear();
  }

  void addSession({required String id, required String duration, required int phasesNum}) {
    var sessionBox = Hive.box("sessions");
    sessionBox.put(id, Session(DateFormat("dd MMM\nyyyy").format(DateTime.now()), duration, phasesNum));
  }

  Session getSession({required String id}) {
    var sessionBox = Hive.box("sessions");
    return sessionBox.get(id);
  }
}