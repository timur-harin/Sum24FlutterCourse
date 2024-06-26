import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:education/templates/lab7/main.dart';

void main() {
  group('Widget Test', () {
    testWidgets('renders Hello World text', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(
        child: MaterialApp(home: MyHomePage()),
      ));

      final textFinder = find.text('Hello World!');

      expect(textFinder, findsOneWidget);
    });
  });
}
