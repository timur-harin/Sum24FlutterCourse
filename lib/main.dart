import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

void main() {
  // First task
  var book = Book("ABC", "bob", 100);
  book.bookDetails();

  // Second task
  var fictionBook = FictionBook("Fiction", "Abc", "bob", 15);
  fictionBook.bookDetails();

  // Third task
  print(book.toJson());

  // Fourth task
  print(calculateArea(length: 12, width: 5));

  // Fifth task
  var user = User("Vasya", email: "ASDkasldkasod");
  user.printUserDetails();

  // App runner
  runApp(const MainApp());
}

class User {
  String name;
  int? age;
  String? email;

  User(this.name, {this.age, this.email});
  void printUserDetails() {
    print("Name: [$name]\nAge: [${age ?? "N/A"}]\nEmail: [${email ?? "N/A"}]");
  }

}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  if (shape == "rectangle") {
    return length * width;
    } else if (shape == "circle") {
      return 3.14 * length * length;
    } else {
      return 0.0;
    }
  }

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map<String, dynamic> toJson() {
    return {"title": title, 
            "author" : author, 
            "numberOfPages" : numberOfPages};
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(this.genre, String title, String author, int numberOfPages)
   : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    // TODO: implement bookDetails
    print("genre - $genre, author - $author, title - $title, pages number - $numberOfPages");
  }
}

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('author - $author, title - $title, pages number - $numberOfPages');
  }
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
