import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/new_session_screen.dart';
import 'screens/active_session_screen.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ShowerSessionAdapter());
  Hive.registerAdapter(TemperaturePhaseAdapter());

  await Hive.openBox<ShowerSession>('shower_sessions');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/new-session': (context) => NewSessionScreen(),
        '/active-session': (context) => ActiveSessionScreen(
          ModalRoute.of(context)!.settings.arguments as ShowerSession, // Pass the argument here
        ),
      },
    );
  }
}
