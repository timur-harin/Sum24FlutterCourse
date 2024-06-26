import 'dart:collection';

import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://cdn1.ozonusercontent.com/s3/club-storage/images/article_image_752x940/16/c500/147442b1-8d1b-44e1-a5b5-e18033b1c689.jpeg';
    const name = 'Kitty Smol';
    const description = 'The kitten is looking upwards';

    // Act
    // TODO add test using pumpWidget
    mockNetworkImagesFor(() async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
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
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    });




    expect(find.text(name), findsAny);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/custom_button_test.dart
  });
}
