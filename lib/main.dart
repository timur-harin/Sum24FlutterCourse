import 'package:education/templates/lab2/lab2.dart';
import 'package:flutter/material.dart';


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
              TextButton(
                onPressed: () {
                  Book myBook = Book('Harry Potter', 'Rowling', 500);
                  myBook.bookDetails();
                },
                child: Text('What a book?'),
              ),
              TextButton(
                onPressed: () {
                  FictionBook myFictionBook = FictionBook('Harry potter and half blood prince', 'Joanne Rowling', 560, 'Fantasy');
                  myFictionBook.bookDetails();
                },
                child: Text('What a fiction book?'),
              ),
              TextButton(
                onPressed: () {
                  Book myBook = Book('Harry Potter', 'Rowling', 500);
                  print(myBook.toJson());
                },
                child: Text('What is my book?'),
              ),
              TextButton( 
                onPressed: () {
                  double length = 10;
                  double width = 5;
                  Widget child = Text('Rectangle'); 
                  print(calculateArea(length: length, width: width));
              }, 
              child: Text('What area is this?'),
              ),
              TextButton(
                onPressed: () {
                  User myUser = User(name: 'Harry Potter', age: 44, email: 'HarryPotter@hogwarts.university');
                  myUser.printUserDetails();
                }, 
                child: 
                  const Text('Who am I?'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
