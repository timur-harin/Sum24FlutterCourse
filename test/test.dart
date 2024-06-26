import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/lab7/main.dart';


void main() {
  testWidgets('My Home Page has a title and a message', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: MyHomePage()),
      ),
    );
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
