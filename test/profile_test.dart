import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';


void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl =
        'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_65ae9228b707252a16e28033_65ae928d448bbb2f93ea5d6d/scale_1200';
    const name = 'Panda is tired';
    const description = 'Software Developer';

    // Act
    // TODO add test using pumpWidget
    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProfileCard(
          imageUrl: imageUrl,
          name: name,
          description: description,
        ),
      ),
    )));


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
