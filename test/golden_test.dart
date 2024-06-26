import 'package:education/templates/lab6/login.dart';
import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testGoldens('LoginScreen golden test', (WidgetTester tester) async {
    final builder = GoldenBuilder.grid(
      columns: 1,
      widthToHeightRatio: 0.5,
    )..addScenario('Login Screen', MaterialApp(home: LoginScreen(onLocaleChange: _dummyLocaleChange)));

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(1000, 2000),
      wrapper: (child) {
        return ChangeNotifierProvider(
          create: (_) => ThemeNotifier(ThemeData.light()),
          child: MaterialApp(
            theme: ThemeData.light(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ru', ''),
            ],
            home: child,
          ),
        );
      },
    );

    await screenMatchesGolden(tester, 'login_screen');

    // Test using flutter test test/golden_test.dart
  });
}

void _dummyLocaleChange(Locale locale) {
  print('Locale changed to: $locale');
}