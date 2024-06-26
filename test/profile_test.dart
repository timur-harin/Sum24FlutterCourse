import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget() {
  return MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZkM581fr_zlyDuXSY5RhrfQim13-iAvEhYA&s',
        name: 'Amir on lab',
        description: 'Student without sleep 0_0',
      ),
    ),
  );
}

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZkM581fr_zlyDuXSY5RhrfQim13-iAvEhYA&s';
    const name = 'Amir on lab';
    const description = 'Student without sleep 0_0';

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

      expect(find.text('Amir on lab'), findsOneWidget);

      expect(find.text('Student without sleep 0_0'), findsOneWidget);

      expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/profile_test.dart
  });
}
