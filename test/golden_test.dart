// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:education/livecoding/pixel_perfect/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:education/main.dart';

void main() {
  testWidgets('SplashPage matches golden file', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashPage()));

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(SplashPage),
      matchesGoldenFile('assets/tests/Splash.png'),
    );
  });
}
