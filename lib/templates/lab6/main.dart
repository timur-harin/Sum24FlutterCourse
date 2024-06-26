import 'package:education/templates/lab6/login.dart';
import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'provider.dart';

void main() {
  runApp(
    MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (_) => ThemeNotifier(ThemeData.light())),
    ChangeNotifierProvider(create: (_) => LocaleNotifier()),
    ],
    

    child: MyApp(),
    ),

  );
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localNotifier = Provider.of<LocaleNotifier>(context).currentLocale;
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) {
        return MaterialApp(
          locale: localNotifier,
          theme: theme.currentTheme,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // Add your generated delegate here
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

