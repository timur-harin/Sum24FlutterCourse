void main() {
  Book book = Book("re", "er", 3);
  book.bookDetails();

  print("");
  FictionBook fBook = FictionBook("a", "b", "c", 4);
  fBook.bookDetails();

  print("");
  print(book.toJson());

  print("");
  print(calculateArea(length: 5, width: 4));
  print(calculateArea(width: 12, length: 4, shape: "circle"));

  print("");
  User user = User("maks", null, null);
  user.printUserDetails();
}

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title, Author: $author, numberOfPages: $numberOfPages");
  }
}

class FictionBook extends Book {
  FictionBook(this.genre, String title, String author, int numberOfPages)
      : super(title, author, numberOfPages);

  final String genre;

  @override
  void bookDetails() {
    print(
        "Genre: $genre, Title: $title, Author: $author, numberOfPages: $numberOfPages");
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "author": this.author,
      "numberOfPages": this.numberOfPages
    };
  }
}

double calculateArea(
    {String shape = "rectangle",
    required double length,
    required double width}) {
  if (shape == "rectangle") {
    return length * width;
  } else if (shape == "circle") {
    return 3.14 * length * length;
  }
  return -1;
}

class User {
  String name;
  int? age;
  String? email;
  User(this.name, this.age, this.email);

  void printUserDetails() {
    print("Name: $name");
    print("Age: ${age ?? "N/A"}");
    print("Email: ${email ?? "N/A"}");
  }
}
