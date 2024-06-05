class Book with JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Book({this.title, this.author, this.numberOfPages});

  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(
      {required this.genre,
      required String title,
      required String author,
      required int numberOfPages})
      : super(title: title, author: author, numberOfPages: numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print('Genre: $genre');
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
  if (shape == "circle") {
    return 3.14 * length * length;
  } else {
    return length * width;
  }
}

class User {
  final String name;
  final int? age;
  final String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print('Name: $name');
    print('Age: ${age ?? "N/A"}');
    print('Email: ${email ?? "N/A"}');
  }
}

void main() {
  var book = Book(
      title: "The strategy of lying",
      author: "Mikhail Vedagor/Gorbachev",
      numberOfPages: 274);
  book.bookDetails();

  var fictionBook = FictionBook(
      genre: 'Roman',
      title: 'The Great Gatsby',
      author: 'Francis Scott',
      numberOfPages: 256);
  fictionBook.bookDetails();

  var jsonExample = book.toJson().toString();
  print(jsonExample);

  double area1 = calculateArea(length: 10, width: 3, shape: "rectangle");
  print("Area of the rectangle: $area1");

  double area2 = calculateArea(length: 15, width: 2, shape: "circle");
  print("Area of the rectangle: $area2");

  var user = User(name: "Dziyana", age: 20);
  user.printUserDetails();
}
