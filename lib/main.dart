import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:/education/templates/lab2/lab2.dart';

void main() {
  // runApp(const MainApp());
  Book book = Book("War and Peace", "Leo Fat", 1800);
  book.BookDetails();

  FictionBook fictionBook = FictionBook("React for beginers", "Someone", 300, "Education");
  fictionBook.BookDetails();

  print(book.toJson());

  print(calculateArea(length: 10, width: 0, shape: 'circle'));

  User user = User(name: "John Smith", age: 40);

  user.printUserDetails();
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
