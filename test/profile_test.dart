import 'dart:collection';

import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6Nr29VUCD3uNCb-zbUqXdZLqbMkMMmq1fLw&s';
    const name = 'John Doe';
    const description = 'Software Developer';

    // Act
<<<<<<< HEAD
    (WidgetTester tester) async {
      const imageUrl =
          'https://www.fonstola.ru/pic/201207/1680x1050/fonstola.ru_79414.jpg';
      const name = 'Something name';
      const description = 'Software Developer';

      await mockNetworkImagesFor(() async => await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: ProfileCard(
                  imageUrl: imageUrl,
                  name: name,
                  description: description,
                ),
              ),
            ),
          ));
    };

    // Assert
    expect(find.byType(ProfileCard), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
=======
    // TODO add test using pumpWidget
    tester.pumpWidget(
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
    // TODO add assertions using expect and findsOneWidget

    expect(find.text(name), findsAny);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/custom_button_test.dart
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
  });
}
