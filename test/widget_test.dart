import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/lab7/main.dart';

void main() {
  testWidgets('MyHomePage has a Text widget that displays "Hello World!"', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyHomePage());

    // Verify that our Text widget displays "Hello World!".
    expect(find.text('Hello World!'), findsOneWidget);
  });
}