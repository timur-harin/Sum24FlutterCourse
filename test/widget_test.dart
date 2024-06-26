import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:education/templates/lab7/main.dart';

void main(){
  testWidgets("Testing for task 2", (
      WidgetTester tester)async{
    await tester.pumpWidget(MaterialApp(home: MyHomePage()));
    expect(find.text("data"), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });
  //

}