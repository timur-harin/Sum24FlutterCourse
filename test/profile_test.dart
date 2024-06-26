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
    // // TODO add test using pumpWidget
    // https://pub.dev/packages/network_image_mock
    await mockNetworkImagesFor(() => tester.pumpWidget(
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
    // // TODO add assertions using expect and findsOneWidget
    expect(find.byType(ProfileCard), findsOneWidget);
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
    expect((avatar.backgroundImage as NetworkImage).url, equals(imageUrl));

    // Test using flutter test test/profile_test.dart
    // Done. All tests pass!
  });
}
