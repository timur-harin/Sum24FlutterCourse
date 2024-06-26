import 'package:education/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App should have a title', (WidgetTester tester) async {
    await tester.pumpWidget(MainApp());

    expect(find.text('Your App Title'), findsOneWidget);
  });
}