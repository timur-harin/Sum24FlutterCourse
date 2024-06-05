import 'package:education/templates/lab2/lab2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group_button/group_button.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Book book = Book("Harry Potter", "JK Rowling", 100);
                  book.bookDetails();
                },
                child: const Row(
                  children: [
                    Icon(Icons.question_mark_rounded),
                    Text("Book Details")
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  FictionBook book =
                      FictionBook("Pirates of Carribean", "J. K. Rowling", 100, "Fiction");
                  print(book.toJson());
                },
                child: const Row(
                  children: [
                    Icon(Icons.question_mark_rounded),
                    Text("Fiction Book Details")
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Book book = Book("Alice", "Lewis Carroll", 1030);
                  print(book.toJson());
                },
                child: const Row(
                  children: [
                    Icon(Icons.question_mark_rounded),
                    Text("Book toJson")
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  print(calculateArea(length: 100, width: 100));
                },
                child: const Row(
                  children: [
                    Icon(Icons.question_mark_rounded),
                    Text("Calculate Area")
                  ],
                ),
              ),
            ),
             Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                 User user = User("Name", 10, null);
                 user.printUserDetails();
                },
                child: const Row(
                  children: [
                    Icon(Icons.question_mark_rounded),
                    Text("User null-safety")
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
