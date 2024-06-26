import 'package:flutter_test/flutter_test.dart';
import 'package:education/templates/lab7/main.dart';

void main() {
  testWidgets('MyHomePage has a Text widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MyHomePage());
    expect(find.text('Hello Flutter Developers!'), findsOneWidget);
  });
}