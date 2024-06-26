import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget(String imageUrl, String name, String description) {
  return MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl: imageUrl,
        name: name,
        description: description,
      ),
    ),
  );
}

void main() {
  testWidgets('ProfileCard displays unique information', (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/819695e8-2ac9-496d-830e-edfaa166981b/300x450';
    const name = 'Meg';
    const description = 'Big meg';

    // Act
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(makeTestableWidget(imageUrl, name, description));
    });

    // Assert
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Additional checks
    final circleAvatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
    expect((circleAvatar.backgroundImage as NetworkImage).url, imageUrl);
  });
}
