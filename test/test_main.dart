import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/lab7/main.dart';

void main() {
  testWidgets('Main app test', (WidgetTester tester) async {
    // Загружаем приложение
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );

    // Проверяем наличие виджета MyHomePage
    expect(find.byType(MyHomePage), findsOneWidget);

    // Проверяем наличие текста "Hello World!"
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
