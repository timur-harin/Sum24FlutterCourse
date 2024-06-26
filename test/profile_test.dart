import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {

        const imageUrl =
            'https://sneg.top/uploads/posts/2023-06/1687935518_sneg-top-p-kietaka-ayanokodzhi-avatarka-pinterest-44.png';
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

    // Act
    // TODO add test using pumpWidget

    // Assert
    // TODO add assertions using expect and findsOneWidget
        expect(find.byType(ProfileCard), findsOneWidget);
        expect(find.byType(CircleAvatar), findsOneWidget);
        expect(find.byType(Text), findsNWidgets(2));
        expect(find.text(name), findsOneWidget);
        expect(find.text(description), findsOneWidget);
    // Test using flutter test test/custom_button_test.dart
  });
}
