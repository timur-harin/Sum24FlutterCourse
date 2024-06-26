import 'package:education/templates/lab6/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/* void main() {
  testGoldens('LoginScreen golden test', (WidgetTester tester) async {
    final builder = GoldenBuilder.grid(
      columns: 1,
      widthToHeightRatio: 0.5,
    )..addScenario('Login Screen', const MaterialApp(home: LoginScreen()));

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(1000, 2000), 
    );

    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'login_screen');
  });
} */

void main() {
  testGoldens('LoginScreen golden test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await expectLater(
      find.byType(LoginScreen),
      matchesGoldenFile('login_screen.png'),
    );
  });
}