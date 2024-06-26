import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://www.shutterstock.com/image-illustration/cool-frog-600w-126641339.jpg';
    const name = 'Cool Frog';
    const description = 'Frog in sunglasses and suit';

    // Act
    await mockNetworkImagesFor(
      () async => await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              imageUrl: imageUrl,
              name: name,
              description: description,
            ),
          ),
        ),
      )
    );

    // Assert
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
  });
}
