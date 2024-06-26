import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:education/templates/lab7/main.dart';

void main() {
  testWidgets('MainApp widget should show "Hello World!"', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: const MyHomePage()));

    // Verify that our widget shows "Hello World!".
    expect(find.text('Hello World!'), findsOneWidget);
  });
}