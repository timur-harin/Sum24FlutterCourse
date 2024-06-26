
import 'package:education/templates/lab7/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    const name = 'John Doe';
    const text = 'Hello World!';

    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(MaterialApp(home: MyHomePage())));

    expect(find.text(name), findsNothing);
    expect(find.text(text), findsOneWidget);
    expect(find.byType(Container), findsAny);

  });
}
