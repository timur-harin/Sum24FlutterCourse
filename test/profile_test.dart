import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    const imageUrl = 'https://example.com/image.jpg';
    const name = 'John Donkihot';
    const description = 'Rickroller';


    await mockNetworkImagesFor(() async => await tester.pumpWidget(const MaterialApp(
      home: ProfileCard(imageUrl: imageUrl, name: name, description: description),
    )));

    
    // tester.pumpWidget(MaterialApp(
    //   home: ProfileCard(imageUrl: imageUrl, name: name, description: description),
    // ));

    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
