import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget buildTestableWidget() {
  return const MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl: 'https://img.razrisyika.ru/kart/46/181925-yabloko-kartinka-dlya-detey-37.jpg',
        name: 'John Doe the First',
        description: 'Software Developer or not',
      )
    )
  );
}

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://img.razrisyika.ru/kart/46/181925-yabloko-kartinka-dlya-detey-37.jpg';
    const name = 'John Doe the First';
    const description = 'Software Developer or not';

    // Act
    await mockNetworkImagesFor( ()async  => await tester.pumpWidget(
      const MaterialApp(
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
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    
    final nameTextWidget = tester.widget<Text>(find.text(name));
    expect(nameTextWidget.style!.fontSize, 20);
    expect(nameTextWidget.style!.fontWeight, FontWeight.bold);

    // Test using flutter test test/profile_test.dart
  });
}
