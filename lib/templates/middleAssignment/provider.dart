import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'start_session_page.dart';
import 'dart:convert';

class DataProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  TemperaturePhase? _selectedTemperaturePhase;
  Duration _selectedSessionDuration = const Duration(seconds: 0);

  List<CustomEvent> contrastShowerDays = [
    CustomEvent(date: DateTime(2024, 6, 5))
        .setPhase(ColdTemperaturePhase())
        .updateDuration(230)
        .updateColor(),
    CustomEvent(date: DateTime(2024, 6, 8))
        .setPhase(HotTemperaturePhase())
        .updateDuration(100)
        .updateDuration(300)
        .updateColor(),
    CustomEvent(date: DateTime(2024, 6, 18))
        .setPhase(ColdTemperaturePhase())
        .updateDuration(10)
        .updateColor(),
  ];

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void loadFromPrefs() {
    if (_prefs != null) {
      final savedEventsJson = _prefs!.getString('contrastShowerDays');
      if (savedEventsJson != null) {
        final savedEvents = jsonDecode(savedEventsJson) as List<dynamic>;
        contrastShowerDays = savedEvents.map((eventData) {
          final date = DateTime.fromMillisecondsSinceEpoch(eventData['date']);
          final phase = eventData['phase'] == 'Cold'
              ? ColdTemperaturePhase()
              : HotTemperaturePhase();
          final duration = Duration(seconds: eventData['duration']);
          return CustomEvent(date: date)
              .setPhase(phase)
              .updateDuration(duration.inSeconds)
              .updateColor();
        }).toList();
      }

      notifyListeners();
    }
  }

  void saveToPrefs() {
    if (_prefs != null) {
      final eventsJson = contrastShowerDays
          .map((event) => {
                'date': event.date.millisecondsSinceEpoch,
                'phase': event.phase.toString(),
                'duration': event.duration.inSeconds,
              })
          .toList();
      _prefs!.setString('contrastShowerDays', jsonEncode(eventsJson));
    }
  }

  TemperaturePhase? get selectedTemperaturePhase => _selectedTemperaturePhase;
  Duration get selectedSessionDuration => _selectedSessionDuration;

  void updateTemperaturePhase(TemperaturePhase? newPhase) {
    _selectedTemperaturePhase = newPhase;
    notifyListeners();
  }

  void updateSessionDuration(Duration newDuration) {
    _selectedSessionDuration = newDuration;
    notifyListeners();
  }

  void addCustomEvent(CustomEvent newEvent) {
    contrastShowerDays.add(newEvent);
    notifyListeners();
  }

  void removeCustomEvent(CustomEvent event) {
    contrastShowerDays.remove(event);
    notifyListeners();
  }

  void updateCustomEvent(CustomEvent oldEvent, CustomEvent newEvent) {
    final index = contrastShowerDays.indexOf(oldEvent);
    if (index != -1) {
      contrastShowerDays[index] = newEvent;
      notifyListeners();
    }
  }
}
