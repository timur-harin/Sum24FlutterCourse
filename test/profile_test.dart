

import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
          (WidgetTester tester) async {

        const imageUrl =
            'https://www.fonstola.ru/pic/201207/1680x1050/fonstola.ru_79414.jpg';
        const name = 'Something name';
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

        expect(find.byType(ProfileCard), findsOneWidget);
        expect(find.byType(CircleAvatar), findsOneWidget);
        expect(find.byType(Text), findsNWidgets(2));
        expect(find.text(name), findsOneWidget);
        expect(find.text(description), findsOneWidget);


      });
}