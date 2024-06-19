import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'home_screen.dart';
import 'theme.dart';
import 'package:provider/provider.dart';
import 'shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const riverpod.ProviderScope(child: MiddleAssigmentApp()),
  ));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const HomeScreen(),
    );
  }
}

class ShowerSession {
  final String name;
  final String comments;
  final List<TemperaturePhase> temperaturePhases;
  final double rating;
  final int overallDuration;

  ShowerSession({
    required this.name,
    required this.comments,
    required this.temperaturePhases,
    required this.rating,
    required this.overallDuration,
  });

  int get duration =>
      temperaturePhases.fold(0, (prev, phase) => prev + phase.duration);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'comments': comments,
      'temperaturePhases':
          temperaturePhases.map((phase) => phase.toMap()).toList(),
      'rating': rating,
      'overallDuration': overallDuration,
    };
  }

  factory ShowerSession.fromMap(Map<String, dynamic> map) {
    var temperaturePhasesFromMap = (map['temperaturePhases'] as List)
        .map((item) => TemperaturePhase.fromMap(item))
        .toList();
    return ShowerSession(
      name: map['name'],
      comments: map['comments'],
      temperaturePhases: temperaturePhasesFromMap,
      rating: map['rating'],
      overallDuration: map['overallDuration'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowerSession.fromJson(String source) =>
      ShowerSession.fromMap(json.decode(source));
}

final showerSessionProvider = riverpod.StateProvider<ShowerSession>((ref) {
  return ShowerSession(
    name: '',
    comments: '',
    temperaturePhases: [],
    rating: 0.0,
    overallDuration: 0,
  );
});

class TemperaturePhase {
  String temperature;
  int duration;

  TemperaturePhase({required this.temperature, required this.duration});

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'duration': duration,
    };
  }

  factory TemperaturePhase.fromMap(Map<String, dynamic> map) {
    return TemperaturePhase(
      temperature: map['temperature'],
      duration: map['duration'],
    );
  }
}

class UserPreferences {
  int preferredSessionDuration;
  List<TemperaturePhase> preferredTemperatureIntervals;

  UserPreferences(
      {required this.preferredSessionDuration,
      required this.preferredTemperatureIntervals});
}

