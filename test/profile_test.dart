import 'dart:io';

import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://www.gstatic.com/webp/gallery3/1.sm.png';
    const name = 'John Doe';
    const description = 'Software Developer';

    // Act
    // TODO add test using pumpWidget
    await mockNetworkImagesFor(
      () async => await tester.pumpWidget(
        ProfileCard(
          imageUrl: imageUrl,
          name: name,
          description: description,
        ),
      ),
    );

    // await tester.pump(new Duration(milliseconds: 1000));

    // final imageFinder = find.image(NetworkImage(imageUrl));
    final nameFinder = find.text(name);
    final descriptionFinder = find.text(description);

    // Assert
    // TODO add assertions using expect and findsOneWidget

    // expect(imageFinder, findsOneWidget);
    expect(nameFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);

    // Test using flutter test test/custom_button_test.dart
  });
}
