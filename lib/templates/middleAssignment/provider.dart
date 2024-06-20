import 'package:flutter/material.dart';
import 'home_page.dart';
import 'start_session_page.dart';

class DataProvider extends ChangeNotifier {
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
