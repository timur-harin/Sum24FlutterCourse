import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://example.com/image.jpg';
    const name = 'John Doe';
    const description = 'Software Developer';

    tester.pumpWidget(
      MaterialApp(
        home: ProfileCard(
          imageUrl: imageUrl,
          name: name,
          description: description,
        ),
      ),
    );

    expect(find.text(name),findsOneWidget);
    expect(find.text(description),findsOneWidget);
    expect(find.byType(Image),findsOneWidget);

    // Act
    // TODO add test using pumpWidget

    // Assert
    // TODO add assertions using expect and findsOneWidget

    // Test using flutter test test/custom_button_test.dart
  });
}
