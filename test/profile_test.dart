import 'dart:collection';

import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget() {
  return MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl: 'https://upload.wikimedia.org/wikipedia/ru/0/07/%D0%9A%D0%BE%D0%BB%D1%8B%D0%B2%D0%B0%D0%BD.png',
        name: 'Kolyvan',
        description: 'character',
      ),
    ),
  );
}

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://example.com/image.jpg';
    const name = 'John Doe';
    const description = 'Software Developer';

    // Act
    // TODO add test using pumpWidget

    // Assert
    // TODO add assertions using expect and findsOneWidget

    // Test using flutter test test/custom_button_test.dart
  });
}
