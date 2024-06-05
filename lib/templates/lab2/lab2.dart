import 'dart:ffi';

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails() {
    print(
        "Title: $title, Author: $author, Number of pages: $numberOfPages', Genre: $genre");
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'author': this.author,
      'numberOfPages': this.numberOfPages,
    };
  }
}

double calculateArea(double length, double width,
    {String shape = 'rectangle'}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  }
  return length * width;
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print("Name: $name");
    if (age == null) {
      print("N/A");
    } else {
      print("Age: $age");
    }

    if (email == null) {
      print("N/A");
    } else {
      print("Email: $email");
    }
  }
}

void main() {
  var book1 = Book("First player ready", "Ernest Klein", 300);
  book1.bookDetails();

  var book2 = FictionBook("First player ready", "Ernest Klein", 300, "Fantasy");
  book2.bookDetails();

  print(book1.toJson());

  print(calculateArea(32, 20));
  print(calculateArea(32, 20, shape: 'circle'));

  var person1 = User(name: "sasha");
  person1.printUserDetails();
  var person2 = User(name: "ilya", age: 18, email: "kezix@gmail.com");
  person2.printUserDetails();
}
