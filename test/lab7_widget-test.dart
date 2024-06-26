import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '/Users/lana/developer/Sum24FlutterCourse-1/lib/templates/lab7/main.dart'; // Make sure to replace 'my_app' with your actual app name

void main() {
  testWidgets('MyHomePage displays Hello World', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        MaterialApp(
          home: MyHomePage(),
        ),
    );

    // Verify that Hello World is displayed.
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
