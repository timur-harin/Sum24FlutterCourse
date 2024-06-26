import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/templates/lab7/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('MyHomePage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );

    expect(find.text('Hello World!'), findsOneWidget);
  });
}