import 'package:flutter/material.dart';

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);
  void bookDetails() {
    print('Title: $title');
    print('Author: $author');
    print('Number of Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print('Genre: $genre');
  }
}

mixin JsonSerializable{
  String? title;
  String? author;
  int? numberOfPages;
  Map<String, dynamic> toJson() => {
    'title': this.title,
    'author': this.author,
    'numberOfPages': this.numberOfPages,
  };
}

double calculateArea({
  required double length,
  required double width,
  String shape = "rectangle",
}) {
  double area;

  switch (shape.toLowerCase()) {
    case "rectangle":
      area = length * width;
      break;
    case "circle":
      area = 3.14 * length * length;
      break;
    default:
      throw ArgumentError("Invalid shape. Supported shapes are 'rectangle' and 'circle'.");
  }

  return area;
}

class User {
  final String name;
  int? age;
  String? email;
  User({
    required this.name,
    this.age,
    this.email,
  });
  void printUserDetails() {
    print('Name: $name');
    print('Age: ${age!= null? age.toString() : 'N/A'}');
    print('Email: ${email!= null? email : 'N/A'}');
  }
}


void main() {
  var myBook = Book('Dart W', 'Lol', 500);
  myBook.bookDetails();
  var myFictionBook = FictionBook('1', 'Lol.D.W', 300, 'сыв');
  myFictionBook.bookDetails();
  print(myBook.toJson());
  print(calculateArea(length: 12, width: 10));
  var user = User(name: 'Babe', age: 30, email: "asas.com");
  user.printUserDetails();
  var anotherUser = User(name: 'Bob');
  anotherUser.printUserDetails();
}
