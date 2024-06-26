import 'package:education/templates/lab6/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('LoginScreen golden test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        'Login Screen',
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: LoginScreen(),
            ),
          ),
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: Size(1000, 2000),
    );

    await screenMatchesGolden(tester, 'goldens/login_screen');
  });
}
