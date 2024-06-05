class Book with JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails() {
    print(
        'Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre');
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'numberOfPages': numberOfPages,
    };
  }
}

double calculateArea(
    {required double length,
    required double width,
    String shape = "rectangle"}) {
  if (shape == "rectangle") {
    return length * width;
  } else if (shape == "circle") {
    return 3.14 * length * length;
  } else {
    throw ArgumentError("Invalid shape. Please use 'rectangle' or 'circle'.");
  }
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print('Name: $name');
    print('Age: ${age ?? 'N/A'}');
    print('Email: ${email ?? 'N/A'}');
  }
}

void main() {
  Book book = Book(
      "Introduction to Algorithms, third edition", "Thomas H. Cormen", 1312);
  book.bookDetails();

  FictionBook fictionBook = FictionBook(
      "Introduction to Algorithms, third edition",
      "Thomas H. Cormen",
      1312,
      "Scientific literature");
  fictionBook.bookDetails();

  print(book.toJson());

  print(calculateArea(length: 5.0, width: 3.0));
  print(calculateArea(length: 2.5, width: 2.5, shape: "rectangle"));
  print(calculateArea(length: 3.0, width: 3.0, shape: "circle"));

  User user1 = User(name: 'John Doe', age: 30, email: 'john.doe@example.com');
  user1.printUserDetails();

  User user2 = User(name: 'Jane Smith');
  user2.printUserDetails();
}
