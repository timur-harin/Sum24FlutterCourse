import 'dart:collection';

import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
<<<<<<< HEAD
import 'package:network_image_mock/network_image_mock.dart';
=======
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
<<<<<<< HEAD
    const imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZkM581fr_zlyDuXSY5RhrfQim13-iAvEhYA&s';
    const name = 'Olesia Novoselova';
    const description = 'Software Developer';

    // Act
    await tester.pumpWidget(
=======
    const imageUrl = 'https://example.com/image.jpg';
    const name = 'John Doe';
    const description = 'Software Developer';

    // Act
    // TODO add test using pumpWidget
    tester.pumpWidget(
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
      MaterialApp(
        home: Scaffold(
          body: ProfileCard(
            imageUrl: imageUrl,
            name: name,
            description: description,
          ),
        ),
      ),
    );

    // Assert
<<<<<<< HEAD
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
=======
    // TODO add assertions using expect and findsOneWidget

    expect(find.text(name), findsAny);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/custom_button_test.dart
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
  });
}
