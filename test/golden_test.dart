import 'package:education/templates/lab6/localization.dart';
import 'package:education/templates/lab6/login.dart';
import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// I have no idea how to do it, i tried many different approaches but none of them worked
// I gave up after 2 hours of trying to make it work
// I'm sorry for not being able to complete this task but i tried my best
void main() {
  testGoldens('LoginScreen golden test', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(
      const MaterialApp(home: LoginScreen(onLocaleChange: _dummyLocaleChange)),
      surfaceSize: const Size(1000, 2000),
    );
    await screenMatchesGolden(tester, 'login_screen');
  });
}

void _dummyLocaleChange(Locale locale) {
  print('Locale changed to: $locale');
}