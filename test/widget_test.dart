import 'package:education/templates/lab7/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(),
    ));
    expect(find.text('Hello World!'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });
}