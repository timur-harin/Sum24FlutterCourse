// ignore_for_file: avoid_print

class Book with JsonSerializable{
  // Properties
  final String title;
  final String author;
  final int numberOfPages;

  // Generative constructor
  Book(this.title, this.author, this.numberOfPages);

  // Method
  void bookDetails() {
    print('$author : $title ($numberOfPages p.)');
  }
}


class FictionBook extends Book {
  // New property
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails() {
    print('$author : $title, $genre ($numberOfPages p.)');
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map<String, dynamic> toJson(){
    return {"Title": title, "Author": author, "Number of pages": numberOfPages};
  }
}

const pi = 3.14;
double calculateArea(double length, double width, {String shape = "rectangle"}){
  // your code here
  switch (shape) {
    case 'rectangle':
      return length * width;
    case 'circle':
      return pi * length * length;
  }
  return 0;
  
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, {this.age, this.email});

  void printUserDetails() {
    print('Name: $name Age: ${age ?? "N/A"} Email: ${email ?? "N/A"}');
  }
}

void main() {
  print("\nCall of method to ex. 1");
  Book book = Book("How to learn Flutter", "Timur", 9);
  book.bookDetails();

  print("\nCall of method to ex. 2");
  var fictionBook = FictionBook("What does matter", "Life", 1, "Philosofy");
  fictionBook.bookDetails();

  print("\nCall of method to ex. 3");
  print(book.toJson());

  print("\nCall of method to ex. 4");
  print(calculateArea(10, 5));
  print(calculateArea(10, 5, shape: "circle"));
  
  print("\nCall of method to ex. 5");
  var user1 = User("UserWithoutAgeAndEmail");
  user1.printUserDetails();

  var user2 = User("UserWithAge", age: 18);
  user2.printUserDetails();

  var user3 = User("UserWithAgeAndEmail", email: "ar.popov@innopolis.university", age: 19);
  user3.printUserDetails();
}