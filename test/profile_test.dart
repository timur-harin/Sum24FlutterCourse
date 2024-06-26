import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://avatars.mds.yandex.net/i?id=13f454977d7148bca4ad5fb540c324669f35ec8c-12525791-images-thumbs&n=13';
    const name = 'Student';
    const description = 'Every one knows him';

    // Act
    // TODO add test using pumpWidget
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
    // TODO add assertions using expect and findsOneWidget
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    // Test using flutter test test/profile_test.dart
  });
}
