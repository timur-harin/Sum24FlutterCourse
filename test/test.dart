import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/lab7/main.dart';

void main() {
  group('Basic Widget Tests', () {
    testWidgets('App starts and displays Hello World', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      expect(find.text('Hello World!'), findsOneWidget);
    });

    testWidgets('Scaffold and Center widgets are present', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
    });
  });
}
