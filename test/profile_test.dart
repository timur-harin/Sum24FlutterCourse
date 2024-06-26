import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZkM581fr_zlyDuXSY5RhrfQim13-iAvEhYA&s';
    const name = ' Stasia Malakhova';
    const description = 'just a person with a small brain';

    // Act
    // TODO add test using pumpWidget

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
    ),
    );
    // Assert
    // TODO add assertions using expect and findsOneWidget

    //expect(find.text(imageUrl), findsOneWidget);
    expect(find.text(' Stasia Malakhova'), findsOneWidget);
    expect(find.text('just a person with a small brain'), findsOneWidget);

    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test using flutter test test/custom_button_test.dart

  });
}
