
import 'package:education/templates/lab4/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyHomePage displays "Hello World!"', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
       ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );


    await tester.pump();

    expect(find.text('Hello World!'), findsOneWidget);
  });
}
