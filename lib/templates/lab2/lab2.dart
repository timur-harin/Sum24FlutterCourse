import 'package:flutter/material.dart';

class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("title: $title , author: $author , number of pages: $numberOfPages");
  }

  // Implement the toJson method from the mixin
  @override
  Map<String, dynamic> toJson() {
    var map = {
      "title": title,
      "author": author,
      "numberOfPages": numberOfPages
    };
    return map;
  }
}

class FictionBook extends Book with JsonSerializable {
  String genre;
  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);
  @override
  void bookDetails() {
    print(
        "title: $title , author: $author , number of pages: $numberOfPages , genre: $genre");
  }
}

mixin JsonSerializable {
  String get title;
  String get author;
  int get numberOfPages;

  Map<String, dynamic> toJson() {
    var map = {
      "title": title,
      "author": author,
      "numberOfPages": numberOfPages
    };
    return map;
  }
}

double calculateArea(
    {required double length,
    required double width,
    String shape = "rectangle"}) {
  if (shape == "circle") {
    return 3.14 * length * length;
  }
  return length * width;
}

class User {
  String name;
  int? age;
  String? email;

  User(this.name, this.age, this.email);

  void printUserDetails() {
    print("Name: $name ");
    print("Age: ${age ?? "N/A"} ");
    print("Email: ${email?? "N/A"} ");
  }
  // your code here
}
