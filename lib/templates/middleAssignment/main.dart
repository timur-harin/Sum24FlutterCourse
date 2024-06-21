import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:education/templates/middleAssignment/data/session_settings.dart';
import 'package:education/templates/middleAssignment/screens/home.dart';
import 'package:education/templates/middleAssignment/screens/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // TODO is it effective to await for boxes before running the app?
  await Hive.initFlutter();
  await Boxes.openBoxes();
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatefulWidget {
  static final blueScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    dynamicSchemeVariant: DynamicSchemeVariant.fruitSalad,
  );
  static final redScheme = ColorScheme.fromSeed(
    seedColor: Colors.red,
    dynamicSchemeVariant: DynamicSchemeVariant.fruitSalad,
  );

  const MiddleAssigmentApp({super.key});

  @override
  State<StatefulWidget> createState() => _MiddleAssignmentAppState();
}

class _MiddleAssignmentAppState extends State<MiddleAssigmentApp> {
  @override
  Widget build(BuildContext context) {
    // TODO - complete assignment
    return ValueListenableBuilder(
      valueListenable: Hive.box(Boxes.sessionSettings).listenable(),
      builder: (context, box, widget) => MaterialApp(
        title: 'Middle Assigment',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: switch (
              SessionSettings.fromJson(box.toMap()).initialTemperature) {
            Thermostat.cold => MiddleAssigmentApp.blueScheme,
            Thermostat.hot => MiddleAssigmentApp.redScheme,
          },
          textTheme: const TextTheme(
            labelLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        ),
        routes: <String, WidgetBuilder>{
          '/': (context) => const HomeScreen(),
          '/session': (context) => const ShowerSessionScreen(),
        },
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
