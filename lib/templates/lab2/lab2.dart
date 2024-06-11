import 'dart:math';

int main() {
  //Exercise 1
  Book book = Book("50 shades of gray", "Some gay ass author", 5);
  book.bookDetails();
  //Exercise 2
  FictionBook sciFiBook = FictionBook("Find Nemo Script", "Unknown", 1000000, "fishes");
  sciFiBook.bookDetails();
  //Exercise 3
  print(book.toJson());
  //Exercise 4
  print(calculateArea(length: 10, width: 10));
  print(calculateArea(length: 10, width: 0, shape: "Circle"));
  //Exercise 5
  User user1 = User(username: "BlazZ1t", age: 18, email: "klimspy@gmail.com");
  User user2 = User(username: "AssassinKiller2015", age: 99);
  User user3 = User(username: "Certified Racist", email: "none@ofyour.buissiness");
  User user4 = User(username: "Not certified racist");
  user1.printUserDetails();
  user2.printUserDetails();
  user3.printUserDetails();
  user4.printUserDetails();
  return 0;
}

class Book with JsonSerializable{
  final String title;
  final String author;
  final int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title by $author with $numberOfPages pages");
  }
}

class FictionBook extends Book{
  String genre;
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  @override
  void bookDetails() {
    print("This is a $genre book called $title by $author with $numberOfPages pages");
  }
  // your code here
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["title"] = this.title;
    map["author"] = this.author;
    map["numberOfPages"] = this.numberOfPages;
    return map;
  }
}

double calculateArea({required double length, required double width,
  String shape = "Rectangle"}){
  if (shape == "Rectangle") {
    return width * length;
  } else if (shape == "Circle"){
    return 3.14 * sqrt(length);
  }
  return 0;
  // your code here
}

class User{
  String username;
  int? age;
  String? email;
  User({required this.username, this.age, this.email});
  void printUserDetails() {
    Object ageNull = age ?? "N/A";
    Object emailNull = email ?? "N/A";

    print("Name: [$username], Age: [$ageNull], Email: [$emailNull]");
  }
}
