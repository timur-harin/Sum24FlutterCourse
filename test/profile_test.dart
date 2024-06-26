import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://avatars.dzeninfra.ru/get-zen_doc/62191/pub_5d8295c'
        '1a3f6e400ad807c51_5d836e7335c8d800ad6a83bd/scale_1200';
    const name = 'Топ 5 худших онлайн игр. Красавчик Дзен';
    const description = '1 место: мир танков.';

    // Act
    // TODO add test using pumpWidget
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ProfileCard(
                imageUrl: imageUrl,
                name: name,
                description: description
            ),
          ),
        ))
    );


    // Assert
    // TODO add assertions using expect and findsOneWidget
    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(ProfileCard), findsOneWidget);
    // Test using flutter test test/custom_button_test.dart
  });
}
