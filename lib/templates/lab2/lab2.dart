import 'package:flutter/foundation.dart';

void main() {
  Book book = Book("Pu-pu-puu", "Aleksandr Isupov", 21);
  book.bookDetails();
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

class FictionBook {
  // your code here
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