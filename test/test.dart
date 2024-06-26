
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:education/templates/lab7/main.dart';


void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(),
    ));

    final textFinder = find.text('Hello World!');
    expect(textFinder, findsAny);
  });
}
