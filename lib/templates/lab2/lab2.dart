import 'dart:html_common';

class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);
  void bookDetails() {
    print("$title is written by $author and has $numberOfPages pages.");
  }
  @override
  Map<String, String> toJson() {
    Map<String, String> map = {'title' : '$title', 'author' : '$author', 'numberOfPages' : '$numberOfPages'};
    return map;
  }
}

class FictionBook extends Book {
  String genre = "fiction";
  FictionBook(String title, String author, int numberOfPages, String  genre) :super(title, author, numberOfPages) {
    this.genre = genre;
  }
  @override
  void bookDetails() {
    print("$title with genre $genre is written by $author and has $numberOfPages pages.");
  }
}

mixin JsonSerializable {
  Map<String, String> toJson();
}

double calculateArea(double length, double width, {String shape = "rectangle"}) {
  double area;
  double pi = 3.14;
  if (shape == "circle") {
    area = pi * length * length;
    return area;
  } else {
    area = length * width;
    return area;
  }
}

class User{
  String name;
  int? age;
  String? email;
  User(this.name, {this.age, this.email});
  void printUserDetails() {
    String? userAge;
    String? userEmail;
    if (age == null) {
      userAge = "N/A";
    }
    if (email == null) {
      userEmail = "N/A";
    }
    print("Name: $name Age: $userAge Email: $userEmail");
  }
}

void main() {
  // task 1
  Book book = Book('Loba', 'Alice', 15);
  book.bookDetails();
  // task 2
  FictionBook fictionBook = FictionBook('Loba', 'Alice', 15, 'fiction');
  fictionBook.bookDetails();
  // task 3
  Map<String, String> map = book.toJson();
  print(map);
  // task 4
  print(calculateArea(10, 5));
  print(calculateArea(5, 10, shape: "circle"));
  // task 5
  User user1 = User('Alex');
  user1.printUserDetails();
  User user2 = User('Oleg', age: 15);
  user2.printUserDetails();
  User user3 = User('Nikita', email: 'nikitos@gmail.com');
  user3.printUserDetails();
  User user4 = User('Vlad', age: 21, email: 'vladik@gmail.com');
  user4.printUserDetails();
}