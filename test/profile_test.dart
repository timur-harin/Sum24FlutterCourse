import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
          (WidgetTester tester) async {
        // Arrange
        const imageUrl = 'https://gameguru.ru/media/publications/392_MK0mC9F.jpg';
        const name = 'Vladimir Zhidkov';
        const description = 'Software Developer';

        await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ProfileCard(
                imageUrl: imageUrl,
                name: name,
                description: description, onTap: () {},
              ),
            ),
          ),
        ));

        expect(find.text(name), findsOneWidget);
        expect(find.byType(ProfileCard), findsOneWidget);
        expect(find.text(description), findsOneWidget);
        expect(find.byType(CircleAvatar), findsAny);
      }
    );
}