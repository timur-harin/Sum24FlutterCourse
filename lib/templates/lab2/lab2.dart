import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

void main() => runApp(const Lab1());

class Lab1 extends StatelessWidget {  
  const Lab1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LAb1HomePage(),
    );
  }
}

class LAb1HomePage extends StatelessWidget {
  const LAb1HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.stars),
        title: const Text('Lab 2'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: myWidget(),
    );
  }
}

Widget myWidget() {
  
  Book book = Book("Atlas Shrugged", "Ayn Rand", 1364);

  book.bookDetails();

  FictionBook fictionBook = FictionBook("The Lord of the Rings", "John Ronald Reuel Tolkien", 1207, "Fantasy");

  fictionBook.bookDetails();

  User user = User(name: "Scott Pilgrim", age: 23, email: "scottpilgrim@example.boom");

  user.printUserDetails();

  return Container();
}

class Book {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  bookDetails() {
    print("Title: $title");
    print("Author: $author");
    print("Number of Pages: $numberOfPages");
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  bookDetails() {
    super.bookDetails();
    print("Title: $title");
    print("Author: $author");
    print("Number of Pages: $numberOfPages");
    print("Genre: $genre");
  }
}

mixin JsonSerializable on Book {
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "author": author,
      "numberOfPages": numberOfPages,
    };
  }
}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  if (shape == "circle") {
    return 3.14 * length * length;
  } else {
    return length * width;
  }
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  printUserDetails() {
    print("Name: ${name}");
    print("Age: ${age ?? "N/A"}");
    print("Email: ${email ?? "N/A"}");
  }
}