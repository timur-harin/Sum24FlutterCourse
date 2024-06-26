import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget() {
  return MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZkM581fr_zlyDuXSY5RhrfQim13-iAvEhYA&s',
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
    const imageUrl =
        'https://grizly.club/uploads/posts/2023-02/1676180979_grizly-club-p-w-klipart-23.png';
    const name = 'Danila';
    const description = 'Super puper programmer';

    // Act
    // TODO add test using pumpWidget
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
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
    // TODO add assertions using expect and findsOneWidget

    expect(find.text('Danila'), findsOneWidget);

    expect(find.text('Super puper programmer'), findsOneWidget);

    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/profile_test.dart
  });
}
