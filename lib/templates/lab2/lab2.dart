void main() {
  Book book = Book(title: "EGE", author: "Some aouthor", numberOfPages: 20);
  book.bookDetails();
  FictionBook fictionBook = FictionBook(title: "Flutter for Beginners", author: "Timur Harin", numberOfPages: 999, genre: "Mystery");
  fictionBook.bookDetails();


  print(book.toJson());
  print(" rectangle: ${calculateArea(length: 5.0, width: 5.0)}");
  print(" square: ${calculateArea(length: 100.0)}");
  print("Area of circle: ${calculateArea(length: 5.310, shape: 'circle')}");

  User pete = User(name: "Petea", age: 33, email: "petea@innoppolis.university");
  pete.printUserDetails();

  User sanea = User(name: "Shura");
  sanea.printUserDetails();
}

class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;

  Book({required this.title, required this.author, required this.numberOfPages});

  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook({required String title, required String author, required int numberOfPages, required this.genre})
      : super(title: title, author: author, numberOfPages: numberOfPages);

  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre');
  }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this is Book) {
      final book = this as Book;
      data['title'] = book.title;
      data['author'] = book.author;
      data['numberOfPages'] = book.numberOfPages;
    }
    return data;
  }
}

double calculateArea({required double length, double? width, String shape = 'rectangle'}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  } else {
    return length * (width ?? length); 
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
