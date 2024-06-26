import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:education/templates/lab6/login.dart';
import 'package:education/templates/lab6/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import generated localizations

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  testGoldens('LoginScreen golden test', (WidgetTester tester) async {
    final builder = GoldenBuilder.grid(
      columns: 1,
      widthToHeightRatio: 0.5,
    )..addScenario(
        'Login Screen',
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(ThemeData.light()),
          child: MaterialApp(
            theme: ThemeData.light(),
            localizationsDelegates: [
              AppLocalizations.delegate, 
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('ru', ''),
            ],
            home: LoginScreen(),
          ),
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: Size(1000, 2000),
    );


    await tester.pumpAndSettle();


    await screenMatchesGolden(tester, 'login_screen');
  });

}
