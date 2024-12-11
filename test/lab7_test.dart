import 'package:education/templates/lab7/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('We should be friendly and greet a user', (tester) async {
    await tester.pumpWidget(MaterialApp(home: MyHomePage()));
    final helloFinder = find.text('Hello World!');
    expect(helloFinder, findsOneWidget);
  });
}
