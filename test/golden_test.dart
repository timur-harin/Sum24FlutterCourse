import 'package:education/templates/lab6/card.dart';
import 'package:education/templates/lab6/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('LoginScreen golden test', (WidgetTester tester) async {
    final widget = ProfileCard(
      imageUrl: 'https://example.com/image.jpg',
      name: 'John Doe',
      description: 'Software Developer',
    );

    final builder = GoldenBuilder.column()..addScenario('Login screen', widget);

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: Size(1000, 2000),
    );

    // TODO fix to pass this using 'flutter test'

    await screenMatchesGolden(tester, 'login_screen');

    // Test using flutter test test/golden_test.dart
  });
}

class Scenario {
  const Scenario();
}
