import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget() {
  return MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl: 'https://imgs.smoothradio.com/images/191589?width=1200&crop=1_1&signature=KHg-WnaLlH9KsZwE-qYgxTkaSpU=',
        name: 'Rick',
        description: 'Roll',
      ),
    ),
  );
}

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    const imageUrl = 'https://imgs.smoothradio.com/images/191589?width=1200&crop=1_1&signature=KHg-WnaLlH9KsZwE-qYgxTkaSpU=';
    const name = 'Rick';
    const description = 'Roll';
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

      expect(find.text('Rick'), findsOneWidget);

      expect(find.text('Roll'), findsOneWidget);

      expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/profile_test.dart
  });
}