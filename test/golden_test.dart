import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('ProfileCard golden test', (WidgetTester tester) async {
    final widget = ProfileCard(
      imageUrl: 'https://example.com/image.jpg',
      name: 'John Doe',
      description: 'Software Developer',
    );

    final builder = GoldenBuilder.column()
      ..addScenario('ProfileCard scenario', widget);

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: Size(400, 200), 
    );

    await screenMatchesGolden(tester, 'profile_card');
  });
}