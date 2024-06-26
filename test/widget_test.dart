import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/lab7/main.dart';

void main() {

  testWidgets('MyHomePage displays "Hello World!"', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );

    final textFinder = find.text('Hello World!');

    expect(textFinder, findsOneWidget);
  });
  // flutter test test/widget_test.dart
}
