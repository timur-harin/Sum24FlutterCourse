import 'package:flutter_test/flutter_test.dart';
import 'package:education/templates/lab7/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('MyHomePage has a Text widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const MyHomePage()));
    expect(find.text('Hello World!'), findsOneWidget);
  });
}