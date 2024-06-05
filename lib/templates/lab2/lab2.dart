void main() {
  Book book = Book("Harry Potter", "J.K. Rowling", 400);
  book.bookDetails();

  FictionBook fictionBook = FictionBook("Harry Potter", "J.K. Rowling", 400, "Fantasy");
  fictionBook.bookDetails();

  print("ToJson()");
  print(fictionBook.toJson());

  print("Area of square 10x10: ");
  print(calculateArea(length: 10, width: 10));

  print("Area of rectangle 20x10: ");
  print(calculateArea(length: 20, width: 10, shape: "rectangle"));

  print("Area of square 11x11: ");
  print(calculateArea(length: 11, width: 11, shape: "square"));

  print("Area of circle with radius 10: ");
  print(calculateArea(length: 10, width: 10, shape: "circle"));

  print("User details: ");
  User user = User(name: "Woolfer0097", age: 18, email: "Woolfer0097@yandex.ru");
  user.printUserDetails();

  User userWithoutAge = User(name: "Woolfer0097", email: "Woolfer0097@yandex.ru");
  userWithoutAge.printUserDetails();

  User userWithoutEmail = User(name: "Woolfer0097", age: 18);
  userWithoutEmail.printUserDetails();

  // User userWithoutName = User(age: 18, email: "Woolfer0097@yandex.ru");
  // userWithoutName.printUserDetails();
}

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  bookDetails() {
    print("Title: $title, Author: $author, Number of pages: $numberOfPages");
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  
  @override
  bookDetails() {
    print("Title: $title, Author: $author, Number of pages: $numberOfPages, Genre: $genre");
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

double? calculateArea({required double length, required double width, String shape = "rectangle"}) {
  if (shape == "rectangle") {
    return length * width;
  } else if (shape == "square") {
    return length * length;
  } else if (shape == "circle") {
    return 3.14 * length * length;
  }
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  printUserDetails() {
    print("Name: $name\n");
    if (age != null) {
      print("Age: $age\n");
    } else {
      print("N/A\n");
    }
    if (email != null) {
      print("Email: $email\n");
    } else {
      print("N/A\n");
    }
  }
}
