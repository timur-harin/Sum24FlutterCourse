import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/lab7/main.dart';

void main() {
  testWidgets('MyHomePage displays "Hello World!"', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );

    // Create the Finders
    final textFinder = find.text('Hello World!');

    // Verify the text appears exactly once in the widget tree
    expect(textFinder, findsOneWidget);
  });
}
