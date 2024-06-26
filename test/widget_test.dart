import 'package:education/templates/lab4/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Hello World test', (WidgetTester tester) async {
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
