import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget() {
  return MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl: 'https://prnt.sc/6IuQPfsJdQWr',
        name: 'John Doe',
        description: 'Software Developer',
      ),
    ),
  );
}

void main() {
  testWidgets('ProfileCard displays correct information', (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://prnt.sc/6IuQPfsJdQWr';
    const name = 'John Doe';
    const description = 'Software Developer';

    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProfileCard(
          imageUrl: imageUrl,
          name: name,
          description: description,
        ),
      ),
    )));

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Software Developer'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/custom_button_test.dart
  });
}
