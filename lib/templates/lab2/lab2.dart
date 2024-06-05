import 'package:flutter/foundation.dart';

void main() {
  Book book = Book("Pu-pu-puu", "Aleksandr Isupov", 21);
  book.bookDetails();

  FictionBook fictionBook = FictionBook("Pu-pu-puu", "Aleksandr Isupov", 21, "Fiction");
  fictionBook.bookDetails();

  print(book.toJson()["title"]);

  print(calculateArea(2.0, 4.0));
  print(calculateArea(21.0, 0.0, shape: "circle"));
  print(calculateArea(21.0, 0.0, shape: "lol"));

  User user = User("Aleksandr", 18, null);
  user.printUserDetails();
}

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title\n"
        "Author: $author\n"
        "Number of pages: $numberOfPages");
  }
}

class FictionBook extends Book {
  String? genre;

  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print("Genre: $genre");
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map<String?, dynamic> toJson() {
    Map<String?, dynamic> map = {
      "title": title,
      "author": author,
      "number of pages": numberOfPages
    };
    return map;
  }
}

double calculateArea(double length, double width, {String shape = "rectangle"}) {
  switch(shape) {
    case("rectangle"):
      return length * width;
    case("circle"):
      return 3.14 * length * length;
  }
  print("Invalid shape type");
  return 0.0;
}

class User {
  final String name;
  int? age;
  String? email;

  User(this.name, this.age, this.email);

  void printUserDetails() {
    print("Name: ${name} Age: ${age ?? "N/A"} Email: ${email ?? "N/A"}");
  }
}