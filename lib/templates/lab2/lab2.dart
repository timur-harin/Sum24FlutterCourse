class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title\nAuthor: $author\nNumber of pages: $numberOfPages");
  }
}

class FictionBook extends Book{
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print("Genre: $genre");
  }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson() => {"title": (this as Book).title, "author": (this as Book).author, "numberOfPages": (this as Book).numberOfPages};
}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  switch (shape) {
    case "circle":
      return 3.14 * length * length;
    default:
      return length * width;
  }
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, [this.age, this.email]);

  void printUserDetails() {
    print("Name: $name\nAge: ${age ?? "N/A"}\nEmail: ${email ?? "N/A"}");

  }
}

void main() {
  print("Classes:");
  var book = Book("Introduction to Algorithms", "Thomas H. Cormen", 450);
  book.bookDetails();
  print("");

  print("Inheritance:");
  var fictionBook = FictionBook("Harry Potter", "J.K. Rowling", 400, "Fantasy");
  fictionBook.bookDetails();
  print("");

  print("Mixins:");
  print(book.toJson());
  print("");

  print("Function:");
  print(calculateArea(length: 10, width: 20));
  print(calculateArea(length: 10, width: 20, shape: "circle"));
  print("");

  print("Null-safety:");
  var user = User("John", 25);
  user.printUserDetails();
}