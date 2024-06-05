import 'package:education/templates/lab2/lab2.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

void main() {
  Book book = Book("Once upon the time", "Druid", 1000);
  book.bookDetails();
  Map<String, dynamic> json = book.toJson();
  print(json);
  calculateArea(length: 20, width: 10);
  calculateArea(length: 20, width: 0, shape: "circle");
  User munir = User(name: "Munir");
  munir.printUserDetails();
  //runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Hello World!'),
              GroupButton(
                isRadio: false,
                buttons: ["12:00", "13:00", "14:30", "18:00", "19:00", "21:40"],
              )
            ],
          ),
        ),
      ),
    );
  }
}
