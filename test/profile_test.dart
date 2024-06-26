import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  String imageUrl = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fru.futuroprossimo.it%2F2023%2F05%2Farriva-il-maschio-sigma-lavanzata-silenziosa-degli-uomini-irresistibili%2F&psig=AOvVaw0Cvn4W0cmCWDCldVCQt-ct&ust=1719475854574000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJD6uO7o-IYDFQAAAAAdAAAAABAE';
  String name = "Joe Schmo";
  String description = "Some rocket lol";

  testWidgets(
    'ProfileCard displays correct information',
    (WidgetTester tester) async {
      await mockNetworkImagesFor(
          () async => await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ProfileCard(
            imageUrl: imageUrl,
            name: name,
            description: description,)))));

      expect(find.text("Joe Schmo"), findsOneWidget);
      expect(find.text("Some rocket lol"), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);

      // Test using flutter test test/custom_button_test.dart
    },
  );
}
