import 'package:flutter/material.dart';
import 'package:flutter_apps/ColdPhasePage.dart';
import 'package:flutter_apps/EndSessionPage.dart';
import 'package:flutter_apps/HotPhasePage.dart';
import 'MainPage.dart';
import 'InputeShowerSessionPreferences.dart';
import 'ShowerSession.dart';

class ShowerApp extends StatelessWidget {
  const ShowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home",
      routes: {
        "/home" : (context) => MainPage(),
        "/beginSession" : (context) => InputeShowerSessionPreferences(),
        "/hotPhasePage" : (context) {
          final args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
          print(args);
          int movesLeft = int.parse(args["movesLeft"].toString());
          return HotPhasePage(movesLeft);
        },
        "/coldPhasePage" : (context) {
          final args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
          int movesLeft = int.parse(args["movesLeft"].toString());
          return ColdPhasePage(movesLeft);
        },
        "/endSession" : (context) => EndSessionPage()
      },
    );
  }
}
