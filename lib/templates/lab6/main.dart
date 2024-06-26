import 'package:education/livecoding/async/main.dart';
import 'package:education/templates/lab6/login.dart';
import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(ThemeData.light()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static Locale change_lang = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      change_lang = locale;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) {
        return MaterialApp(
          theme: Provider.of<ThemeNotifier>(context).currentTheme,
          locale: change_lang,

          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          
          home: LoginScreen(changing: setLocale),

        );
      },
    );
  }
}

