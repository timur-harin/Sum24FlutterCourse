// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/lab7/main.dart'; 

void main() {
  testWidgets('MyHomePage displays Hello World', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );

    // Verify if "Hello World!" is found
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
