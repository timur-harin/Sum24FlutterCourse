import 'dart:collection';

import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://i.insider.com/63333bbf488b340019deb7ad?width=1000&format=jpeg&auto=webp';
    const name = 'Box cat';
    const description = 'Software Developer';

    // Act
    // TODO add test using pumpWidget
<<<<<<< HEAD
    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              imageUrl: imageUrl,
              name: name,
              description: description,
            ),
          ),
        )));
=======
    tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileCard(
            imageUrl: imageUrl,
            name: name,
            description: description,
          ),
        ),
      ),
    );
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc

    // Assert
    // TODO add assertions using expect and findsOneWidget
    expect(find.byType(ProfileCard), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);

    expect(find.text(name), findsAny);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/custom_button_test.dart
  });
}
