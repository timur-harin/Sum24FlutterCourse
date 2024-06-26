import 'package:education/templates/lab6/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testGoldens('LoginScreen golden test', (WidgetTester tester) async {
    final builder = GoldenBuilder.grid(
      columns: 1,
      widthToHeightRatio: 0.5,
    )..addScenario('Login Screen', MaterialApp(
        locale: const Locale("ru"),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ru'),
        ],
        home: LoginScreen())
    );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: Size(1000, 2000),
    );

    await screenMatchesGolden(tester, 'login_screen');

  });
}