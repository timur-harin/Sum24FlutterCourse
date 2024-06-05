class Book with JsonSerializable {
  final String title, author;
  final int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);

  String bookDetails() {
    return 'Book "$title" by $author, number of pages: $numberOfPages';
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  String bookDetails() {
    return 'Book "$title" by $author, genre: $genre, number of pages: $numberOfPages';
  }
}

mixin JsonSerializable {
  String? title, author;
  int? numberOfPages;
  Map toJson() {
    return {title: this, author: this, numberOfPages: this};
  }
}

double calculateArea({double? length, double? width, String shape = "rectangle"}) {
  double result = 0;
  if (width != null && length != null) {
    if (shape == "rectangle") {
      result = width * length;
    } else if (shape == "circle") {
      result = 3.14 * length * length;
    }
  }
  return result;
}

class User{
  String name;
  int? age;
  String? email;
  User(this.name, this.age, this.email);

  void printUserDetails() {
    print("Name: $name Age: ${age ?? "N/A"} Email: ${email ?? "N/A"}");
  }
}

void main() {
  // Task 1
  var book = Book("Title", "Author", 100);
  print(book.bookDetails());
  // Task 2
  var fictionBook = FictionBook("Fiction book", "Author", 1000, "fantasy");
  print(book.bookDetails());
  // Task 3
  print(book.toJson());
  // Task 4
  print(calculateArea(length: 10, width: null));
  print(calculateArea(length: 10, width: 5, shape: "circle"));
  print(calculateArea(length: 10, width: 5));
  // Task 5
  var user1 = User("Alex", null, null);
  user1.printUserDetails();
  var user2 = User("Bob", 19, null);
}
