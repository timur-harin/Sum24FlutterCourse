// import 'package:flutter/material.dart';

class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("$title by $author has $numberOfPages pages");
  }

}

class FictionBook extends Book{
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    print("$genre book $title by $author has $numberOfPages pages");
  }
}

mixin JsonSerializable {
  // your code here
}

double calculateArea(){
  // your code here
}

class User{
  String name = '';
  int? age;
  String? email;

  User({required String name, String? email, int? age}) {
    this.name = name;
    this.email = email;
    this.age = age;
  } 

  void printUserdetails() {
    print("Name: [$name]");
    dynamic age = this.age ?? "N/A";
    print("Age: [$age]");
    String email = this.email ?? "N/A";
    print("Email: [$email]");
  } 
}

void main() {
  var book = Book("Harry Potter", "J.K. Rowling", 400);
  var fictionBook = FictionBook("Harry Potter", "J.K. Rowling", 400, "Fiction");
  book.bookDetails();
  fictionBook.bookDetails();

  print(calculateArea(length: 10, width: 20));
  print(calculateArea(length: 10, width: 20, type: 'circle'));  

  var User1 = User(name: "John", email: "XJ9bB@example.com");
  User1.printUserdetails();
}
