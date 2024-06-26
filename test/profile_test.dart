import 'dart:collection';

import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget() {
  return MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl:
            'https://imgs.smoothradio.com/images/191589?width=1200&crop=1_1&signature=KHg-WnaLlH9KsZwE-qYgxTkaSpU=',
        name: 'John Doe',
        description: 'Software Developer',
      ),
    ),
  );
}

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    const imageUrl =
        'https://imgs.smoothradio.com/images/191589?width=1200&crop=1_1&signature=KHg-WnaLlH9KsZwE-qYgxTkaSpU=';
    const name = 'John Doe';
    const description = 'Software Developer';

    await mockNetworkImagesFor(() async => await tester.pumpWidget(
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

    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}