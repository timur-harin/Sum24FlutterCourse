import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://googleflutter.com/sample_image.jpg';
    const name = 'John Doe';
    const description = 'Software Developer';

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProfileCard(
            imageUrl: imageUrl,
            name: name,
            description: description,
          ),
        ),
      );
    });

    // Act
    // TODO add test using pumpWidget

    // Assert
    // TODO add assertions using expect and findsOneWidget

    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/custom_button_test.dart
    //teste
  });
}
