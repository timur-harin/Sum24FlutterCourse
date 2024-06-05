import 'dart:math';

class Book with JsonSerializable{
  String title;
  String author;
  int numberOfPages;


  Book(this.title, this.author, this.numberOfPages);

  @override
  Map<String, dynamic> toJson()
  {
    Map<String, dynamic> represenatation = {};
    represenatation['title'] = title;
    represenatation['author'] = author;
    represenatation['Number of pages'] = numberOfPages;
    return represenatation;
  }
  
  void bookDetails() {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(this.genre, String title, String author, int nop) : super(title, author, nop);
  
  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages, Genre: $genre');
  }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson();
}

double calculateArea(double length, double width, [String shape = 'rectangle']) {
  if(shape == "circle") {
    return 3.14 * pow(length, 2);
  } else if(shape == "rectangle") {
    return length * width;
  }
  return 0;
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name);

  void printUserDetails() {
    print('Name: $name');
    if(age == null) {
      print('Age: N/A');
    } else {
      print('Age: $age');
    }

    if(email == null) {
      print('Email: N/A');
    } else {
      print('Email: $email');
    }
  }
}

void main() {
  //Task 1
  var book = Book("Dark tower", "Steven King", 345);
  book.bookDetails();

  //Task 2
  var fictionBook = FictionBook("horror", "heart-shaped box", "Jo Hill", 237);
  fictionBook.bookDetails();

  //Task 3
  var m = book.toJson();
  print(m);

  //Task 4
  double area = calculateArea(2.2, 3.1);
  print('area of rectangle is $area');
  area = calculateArea(2, 0, 'circle');
  print('area of circle is $area');

  //Task 5
  User? user;
  user = User("Aleksei");
  user.printUserDetails();

  user.email = 'a.fominykh@innopolis.university';
  user.age = 18;
  user.printUserDetails();
}
