import 'package:education/templates/lab6/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

Widget makeTestableWidget() {
  return const MaterialApp(
    home: Scaffold(
      body: ProfileCard(
        imageUrl: 'https://yandex.ru/images/search?from=tabbar&img_url=https%3A%2F%2Fscontent-hel2-1.cdninstagram.com%2Fv%2Ft51.2885-15%2Fe35%2F116163989_280248493268179_3404840620713874490_n.jpg%3F_nc_ht%3Dscontent-hel2-1.cdninstagram.com%26_nc_cat%3D1%26_nc_ohc%3DQnDgZqzY1sUAX-5FFhs%26oh%3D03fec6c7fe8e68c7fb2b17b82feca69f%26oe%3D5F28164A&lr=121642&pos=11&rpt=simage&text=гендальф%20кивает',
        name: 'Gendalf the Grey',
        description: 'Wizard with gray hat and staff',
      ),
    ),
  );
}

void main() {
  testWidgets('ProfileCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    const imageUrl = 'https://yandex.ru/images/search?from=tabbar&img_url=https%3A%2F%2Fscontent-hel2-1.cdninstagram.com%2Fv%2Ft51.2885-15%2Fe35%2F116163989_280248493268179_3404840620713874490_n.jpg%3F_nc_ht%3Dscontent-hel2-1.cdninstagram.com%26_nc_cat%3D1%26_nc_ohc%3DQnDgZqzY1sUAX-5FFhs%26oh%3D03fec6c7fe8e68c7fb2b17b82feca69f%26oe%3D5F28164A&lr=121642&pos=11&rpt=simage&text=гендальф%20кивает';
    const name = 'Gendalf the Grey';
    const description = 'Wizard with gray hat and staff';

    // Act
     await mockNetworkImagesFor( ()async  => await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileCard(
            imageUrl: imageUrl,
            name: name,
            description: description,
          ),
        ),
      ),
    ));

    // Assert
      expect(find.text('Gendalf the Grey'), findsOneWidget);
      expect(find.text('Wizard with gray hat and staff'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    // Test using flutter test test/profile_test.dart
  });
}
