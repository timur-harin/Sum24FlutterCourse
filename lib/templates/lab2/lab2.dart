import 'package:flutter/material.dart';

void main() => runApp(const Lab2());

class Lab2 extends StatelessWidget {
  const Lab2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.stars),
        title: const Text('Lab 2'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            element(ex1()),
            element(ex2()),
            element(ex3()),
            element(ex4()),
            element(ex5()),
          ],
        ),
      ),
    ));
  }

  Widget element(Widget widget) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: widget,
    );
  }

  Widget ex1() {
    List<Book> books = [
      Book('Book1', 'Author1', 13),
      Book('Book2', 'Author2', 42),
      Book('Book3', 'Author3', 37)
    ];
    List<Text> details = [];
    for (final book in books) {
      details.add(Text(book.bookDetails()));
    }
    return Column(
      children: details,
    );
  }

  Widget ex2() {
    List<FictionBook> books = [
      FictionBook('Book1', 'Author1', 13, 'Thriller'),
      FictionBook('Book2', 'Author2', 42, 'Comedy'),
      FictionBook('Book3', 'Author3', 37, 'Detective')
    ];
    List<Text> details = [];
    for (final book in books) {
      details.add(Text(book.bookDetails()));
    }
    return Column(
      children: details,
    );
  }

  Widget ex3() {
    List<Book> books = [
      Book('Book1', 'Author1', 13),
      Book('Book2', 'Author2', 42),
      Book('Book3', 'Author3', 37)
    ];
    List<Text> details = [];
    for (final book in books) {
      details.add(Text(book.toJson().toString()));
    }
    return Column(
      children: details,
    );
  }

  Widget ex4() {
    return Column(
      children: [
        Text(
            'length: 15, width 22, area: ${calculateArea(width: 22, length: 15)}'),
        Text(
            'radius: 37, area: ${calculateArea(length: 37, width: 0, shape: 'circle')}')
      ],
    );
  }

  Widget ex5() {
    List<User> users = [
      User('Book1', email: 'Author1', age: 13),
      User('Book2', age: 42),
      User('Book3', email: 'Author3')
    ];
    List<Text> details = [];
    for (final book in users) {
      details.add(Text(book.printUserDetails()));
    }
    return Column(
      children: details,
    );
  }
}

class Book with JsonSerializable {
  String title;
  String author;
  int numOfPages;

  Book(this.title, this.author, this.numOfPages);

  String bookDetails() {
    return "$author - $title ($numOfPages)";
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numOfPages, this.genre);

  @override
  String bookDetails() {
    return "$author - $title <$genre> ($numOfPages)";
  }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    switch (runtimeType) {
      case const (Book):
        Book book = this as Book;
        json['title'] = book.title;
        json['author'] = book.author;
        json['numOfPages'] = book.numOfPages;
        return json;
    }
    return json;
  }
}

double calculateArea(
    {required double width,
    required double length,
    String shape = 'rectangle'}) {
  switch (shape) {
    case 'circle':
      return 3.14 * length * length;
    default:
      return length * width;
  }
}

class User {
  String name;
  int? age;
  String? email;

  User(this.name, {this.age, this.email});

  String printUserDetails() {
    return 'Name: $name\nAge: ${age ?? "N/A"}\nEmail: ${email ?? "N/A"}';
  }
}
