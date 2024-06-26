import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/lab7/main.dart'; // Update with your actual project path

void main() {
  testWidgets('Verify Hello World text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );

    expect(find.text('Hello World!'), findsOneWidget);
  });
}
