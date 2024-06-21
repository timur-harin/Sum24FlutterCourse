import 'package:education/templates/middleAssignment/data/models/shower_session.dart';
import 'package:education/templates/middleAssignment/ui/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final sessionProvider =
    ChangeNotifierProvider<SessionNotifier>((ref) => SessionNotifier());
final stateProvider =
    ChangeNotifierProvider<StateNotifier>((ref) => StateNotifier());

final valueProvider =
    ChangeNotifierProvider<ValueNotifier>((ref) => ValueNotifier());

class SessionNotifier extends ChangeNotifier {
  List<ShowerSession> sessions = [];

  void addSession(ShowerSession session) {
    sessions.add(session);
    notifyListeners();
  }

  void editSessionRate(ShowerSession session, String rate) {
    session.rate = rate;
    notifyListeners();
  }

  void setSessions(List<ShowerSession> sessions) {
    this.sessions = sessions;
    notifyListeners();
  }

  // Future<void> saveSessions() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // Assuming you have a toJson method in ShowerSession
  //   final String encodedData = json.encode(sessions.map((session) {
  //     return jsonEncode({
  //       'level': session.level,
  //       'totalTime': session.totalTime,
  //       'numbOfCycles': session.numbOfCycles,
  //       'rate': session.rate,
  //       'startTime': session.startTime,
  //     });
  //   }).toList());
  //   await prefs.setString('savedSessions', encodedData);
  // }

  // Future<void> loadSessions() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? encodedData = prefs.getString('savedSessions');
  //   if (encodedData != null) {
  //     final List<dynamic> decodedData = json.decode(encodedData);
  //     // Assuming you have a fromJson constructor in ShowerSession
  //     final List<ShowerSession> loadedSessions = decodedData
  //         .map((sessionData) => ShowerSession.fromJson(sessionData))
  //         .toList();
  //     setSessions(loadedSessions);
  //   }
  // }

// Future<void> saveSessions(List<ShowerSession> sessions) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String> sessionsString = sessions.map((session) {
//     return jsonEncode({
//       'level': session.level,
//       'totalTime': session.totalTime,
//       'numbOfCycles': session.numbOfCycles,
//       'rate': session.rate,
//       'startTime': session.startTime,
//     });
//   }).toList();
//   await prefs.setStringList('sessions', sessionsString);
// }

// Future<List<ShowerSession>> loadSessions() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String>? sessionsString = prefs.getStringList('sessions');
//   if (sessionsString == null) return [];
//   return sessionsString.map((sessionString) {
//     final Map<String, dynamic> sessionMap = jsonDecode(sessionString);
//     return ShowerSession(
//       level: sessionMap['level'],
//       totalTime: sessionMap['totalTime'],
//       numbOfCycles: sessionMap['numbOfCycles'],
//       rate: sessionMap['rate'],
//       startTime: sessionMap['startTime'],
//     );
//   }).toList();
// }
}

class StateNotifier extends ChangeNotifier {
  String state = "Initial";
  bool isHot = false;
  Color color = bgColor;
  ButtonStyle style = buttonStyle;

  void change() {
    if (state == "Hot") {
      state = "Cold";
      isHot = false;
      color = Colors.blue;
      style = buttonStyle;
    } else if (state == "Cold") {
      state = "Hot";
      isHot = true;
      color = Colors.red;
      style = blackButtonStyle;
    }
    notifyListeners();
  }

  void start() {
    state = "Hot";
    isHot = true;
    color = Colors.red;
    style = blackButtonStyle;
    notifyListeners();
  }

  void reset() {
    state = "Initial";
    isHot = true;
    color = bgColor;
    style = buttonStyle;

    notifyListeners();
  }
}

class ValueNotifier extends ChangeNotifier {
  String level = "Easy";
  int cycles = 4;
  int timeInCycle = 10;
  int cycles_left = 3;

  void setEasy() {
    level = "Easy";
    cycles = 4;
    timeInCycle = 10;
    cycles_left = 3;
    notifyListeners();
  }

  void setMedium() {
    level = "Medium";
    cycles = 6;
    timeInCycle = 40;
    cycles_left = 5;
    notifyListeners();
  }

  void setHard() {
    level = "Hard";

    cycles = 8;
    timeInCycle = 60;
    cycles_left = 7;
    notifyListeners();
  }

  void decreaseCycles() {
    cycles_left--;
    notifyListeners();
  }

  void reset() {
    level = "Easy";
    cycles = 4;
    timeInCycle = 10;
    cycles_left = 3;
  }
}
