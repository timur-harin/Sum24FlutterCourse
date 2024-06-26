import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://example.com/image.jpg';
    const name = 'John Doe';
    const description = 'Software Developer';

    // Act
    // TODO add test using pumpWidget
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const MaterialApp(
          home: ProfileCard(
              description: description, name: name, imageUrl: imageUrl)));
    });

    await tester.pumpAndSettle(Duration(seconds: 5));

    // Assert
    // TODO add assertions using expect and findsOneWidget
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/custom_button_test.dart
  });
}
