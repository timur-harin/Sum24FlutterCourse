import 'package:education/livecoding/async/main.dart';
import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';


Widget buildTestableWidget() {
  return MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl: 'https://www.funnyart.club/uploads/posts/2022-12/1672004549_www-funnyart-club-p-smeshnie-kostili-yumor-40.jpg',
        name: 'John Doe',
        description: 'Software Developer',
      ),
    ),
  );
}

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(buildTestableWidget()));
    // Assert
    // TODO add assertions using expect and findsOneWidget

    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Software Developer'), findsOneWidget);
  });
}
