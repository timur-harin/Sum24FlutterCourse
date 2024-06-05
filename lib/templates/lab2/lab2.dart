import 'package:flutter/foundation.dart';

void main() {
  FictionBook fictionBook = FictionBook("Pu-pu-puu", "Aleksandr Isupov", 21, "Fiction");
  fictionBook.bookDetails();
}

class Book {
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
  final String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
     super.bookDetails();
     print("Genre: $genre");
  }
}

mixin JsonSerializable {
  // your code here
}

double calculateArea() {
  return 1.0;
  // your code here
}

class User {
  // your code here
}
