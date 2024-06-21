import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import 'SessionHistoryScreen.dart';
import 'ShowerSessionProvider.dart';
import 'ShowerTimerProvider.dart';

class ContrastShowerApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ShowerTimerProvider(navigatorKey)),
        ChangeNotifierProvider(
            create: (context) => ShowerSessionProvider()..loadSessions()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: HomeScreen(),
        routes: {
          '/history': (context) => SessionHistoryScreen(),
        },
      ),
    );
  }
}
