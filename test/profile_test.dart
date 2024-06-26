import 'dart:collection';

import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget() {
  return const MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZkM581fr_zlyDuXSY5RhrfQim13-iAvEhYA&s',
        name: 'lab6',
        description: 'lab6 is about testings',
      ),
    ),
  );
}

void main() {
  testWidgets('ProfileCard displays correct information',
          (WidgetTester tester) async {
        // Arrange
        const imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZkM581fr_zlyDuXSY5RhrfQim13-iAvEhYA&s';
        const name = 'lab6';
        const description = 'lab6 is about testings';

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

        // Assert
        // TODO add assertions using expect and findsOneWidget

    expect(find.text(name), findsAny);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

        expect(find.text('lab6'), findsOneWidget);

        expect(find.text('lab6 is about testings'), findsOneWidget);

        expect(find.byType(CircleAvatar), findsOneWidget);

        // Test using flutter test test/profile_test.dart
      });
}
