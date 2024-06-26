import 'dart:io';
import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'http://http.dog/200.jpg';
    const name = 'John Doe';
    const description = 'Software Developer';

    // Act
    // TODO add test using pumpWidget
    await mockNetworkImagesFor( ()async  => await tester.pumpWidget(
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
    // Assert
    // TODO add assertions using expect and findsOneWidget
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    final nameText = find.text(name).evaluate().single.widget as Text;
    expect(nameText.style, isNotNull);

    // Test using flutter test test/custom_button_test.dart
  });
}
