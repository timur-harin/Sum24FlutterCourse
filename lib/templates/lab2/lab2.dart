void main() {
  Book book = Book("Data Structures and Algorithms", "Cormen", 999999);
  book.bookDetails();

  FictionBook fictionBook = FictionBook("Data Structures and Algorithms", "Cormen", 999999, "suffer");
  fictionBook.bookDetails();

  print(book.toJson());

  print(calculateArea(length: 2, width: 3));
  print(calculateArea(length: 3, shape: "circle"));

  User user1 = User(name: "Bob1", age: 10, email: "bob1@mail.com");
  User user2 = User(name: "Bob2", age: 20);
  User user3 = User(name: "Bob3", email: "bob3@mail.com");

  user1.printUserDetails();
  user2.printUserDetails();
  user3.printUserDetails();
}

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("$title by $author with $numberOfPages pages");
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails() {
    print("$title by $author with $numberOfPages pages in genre $genre");
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "author": author,
      "numberOfPages": numberOfPages
    };
  }
}

double calculateArea({double? length, double? width, String shape = "rectangle"}){
  return shape == "rectangle" ? length! * width! : shape == "circle" ? 3.14 * length! * length : 0;
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    dynamic ageToPrint = age ?? "N/A";
    dynamic emailToPrint = email ?? "N/A";
    print("Name: $name\n Age: $ageToPrint\n Email: $emailToPrint");
  }
}
