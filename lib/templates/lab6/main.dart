import 'package:education/templates/lab6/login.dart';
import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(ThemeData.light()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) {
        return MaterialApp(
          theme: theme.currentTheme,
          localizationsDelegates: [
<<<<<<< HEAD
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
=======
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // Add your generated delegate here
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('ru', ''),
          ],
          home: LoginScreen(),
        );
      },
    );
  }
}
<<<<<<< HEAD
=======

>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
