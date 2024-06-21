// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'new_session_screen.dart';
import 'main_screen.dart';
import 'shower_history.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData contrastShowerTheme = ThemeData(
      primaryColor: Colors.blueGrey,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(
        secondary: Colors.cyanAccent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromRGBO(224, 207, 177, 1.0),
      ),
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.cyanAccent),
        ),
      ),
    );

    return MaterialApp(
      title: 'My App',
      theme: contrastShowerTheme,
      initialRoute: '/', // Это начальная страница
      routes: {
        '/': (context) => MainScreen(), // Главная страница
        '/newSession': (context) {
          // Создайте экземпляр ShowerSession
          final session = ShowerSession(
            duration: Duration(seconds: 0),
            temperatureInterval: Duration.zero,
            totalDuration: Duration.zero,
          );
          // Создайте список продолжительности и isHotList
          final durations = [0];
          final isHotList = [false];
          // Верните NewSessionScreen с правильными параметрами
          return NewSessionScreen(session: session, duration: durations, isHotList: isHotList);
        },
        // Добавьте все остальные маршруты здесь
      },
    );
  }
}