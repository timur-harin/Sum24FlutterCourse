import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:education/templates/lab7/main.dart';

import '../../livecoding/async/main.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Hello World!'), findsOneWidget);
  });
}