class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);
  void bookDetails() {
    print("$title, $author, $numberOfPages");
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);
  @override
  void bookDetails() {
    print("$title $author $numberOfPages $genre");
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  Map? toJson() {
    Map? tempMap = {
      "title": title,
      "author": author,
      "numberOfPages": numberOfPages
    };
    return tempMap;
  }
}

double calculateArea(
    {required double length,
    required double? width,
    String? shape = 'rectangle'}) {
  if (shape == 'circle') {
    double pi = 3.14;
    return pi * length * length;
  } else {
    return length * width!;
  }
}

class User {
  String name;
  int? age;
  String? email;
  User(this.name, [this.age, this.email]);
  void printUserDetails() {
    String ageString = age == null ? 'N/A' : age.toString();
    email = email ?? "N/A";
    print("Name: $name Age: $ageString Email: $email");
  }
}

void main() {
  Book book = Book("Javlon", "qdqw", 19);
  book.bookDetails();
  print(book.toJson()); // Verify toJson for Book

  FictionBook fiction = FictionBook("asd", "12", 19, "afsqw");
  fiction.bookDetails();
  print(fiction.toJson());
  double area;
  print(area = calculateArea(length: 21, width: 12));
  User user = User("Jav");
  user.printUserDetails();
}
