


// import 'dart:io';

class Book with JsonSerializable{
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails(){
    if(title!=null && author!=null && numberOfPages!=null){
      print("Book\n title: \"$title\"\n author: $author\n pages: $numberOfPages \n");
    } else {
      print("Book is not exists\n");
    }
  }
}

class FictionBook extends Book{
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title,author,numberOfPages);
  
  @override
  void bookDetails() {
    if(title!=null && author!=null && numberOfPages!=null){
      print("Fiction book\n title: \"$title\"\n author: $author\n genre: $genre\n pages: $numberOfPages\n");
    } else {
      print("Book is not exists\n");
    }
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  Map<String, dynamic> toJson(){
    var map = {"title":title, "author":author, "numberOfPages":numberOfPages};
    return map;
  }
}

double calculateArea({required double length, required double width, String shape = "Rectangle"}){
  switch (shape) {
    case "rectangle":
      return length*width;
    case "circle" :
      return 3.14*length*length;
    default:
      return length*width;
  }
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print("User\n name: $name\n age: ${age ?? "N/A"}\n email: ${email ?? "N/A"}");
  }
}

void main() {
  print("1 exercise:");
  Book newBook = Book("1984","George Orwell",196);
  newBook.bookDetails();

  print("\n2 exercise:");
  FictionBook newFictionBook = FictionBook("A Stainless Steel Rat is Born", "Harry Harrison", 200, "Science fiction");
  newFictionBook.bookDetails();

  print("\n3 exercise:");
  Book bookWithMixin = Book("Harry Potter","Joanne Rowling",300);
  print(bookWithMixin.toJson());

  print("\n4 exercise:");
  print("For rectangle 30/40:");
  print(calculateArea(length:  30, width:  40));
  print("For circle with radius 10");
  print(calculateArea(length: 10, width: 1000000000, shape: "circle"));

  print("\n5 exercise:");
  User user1 = User(name: "Amir", age: 18, email: "amiraminov@example.com");
  user1.printUserDetails();
  User user2 = User(name: "Nike");
  user2.printUserDetails();
}