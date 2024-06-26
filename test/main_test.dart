import 'package:education/templates/lab7/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("My home page prints 'Hello World!'", (tester) async {
    await tester.pumpWidget(MaterialApp(home: MyHomePage()));

    final textFinder = find.text("Hello World!");

    expect(textFinder, findsOneWidget);
  });
}
