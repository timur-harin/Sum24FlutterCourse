import 'package:education/templates/lab7/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    const imageUrl = 'https://example.com/image.jpg';
    const name = 'Hello World!';
    const description = 'Software Developer';

    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(MaterialApp(home: MyHomePage())));

    expect(find.text(name), findsOneWidget);
    expect(find.text(description), findsNothing);
  });
}
