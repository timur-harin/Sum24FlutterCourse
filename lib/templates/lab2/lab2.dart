class Book with JsonSerializable {
  final String title;
  final String author;
  final int column;
  Book(this.author, this.column, this.title);
  void bookDetails() {
    print(title + " " + author + " " + column.toString());
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook(String author, int column, String title, this.genre)
      : super(author, column, title);
  @override
  void bookDetails() {
    print(title + " " + author + " " + column.toString() + " " + genre);
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? column;
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'numberOfPages': column,
    };
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
  String? name;
  int? age;
  String? email;
  User(this.name, this.age, this.email);
  void printUserDetails() {
    String ageString = age?.toString() ?? 'N/A';
    if (email == null) {
      email = "N\A";
    }
    print("Name: [$name] Age: [$ageString] Email: [$email]");
  }
}

void main() {
  Book book = Book("Javlon", 19, "qdqw");
  book.bookDetails();
  print(book.toJson()); // Verify toJson for Book

  FictionBook fiction = FictionBook("asd", 12, "12", "afsqw");
  fiction.bookDetails();
  print(fiction.toJson());
  double area;
  print(area = calculateArea(length: 21, width: 12));
  User user = User("Jav", null, null);
  user.printUserDetails();
}
