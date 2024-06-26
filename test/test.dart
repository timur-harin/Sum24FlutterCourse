import 'package:education/templates/lab7/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  group('Widget Tests', () {
    testWidgets('MyHomePage has a title and message', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
         ProviderScope(
          child: MaterialApp(
            home: MyHomePage(title: 'Test Title', message: 'Test Message'),
          ),
        ),
      );

      
      expect(find.text('Test Title'), findsOneWidget);

     
      expect(find.text('Test Message'), findsOneWidget);
    });
  });
}
