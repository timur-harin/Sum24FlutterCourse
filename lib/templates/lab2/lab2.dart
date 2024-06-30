void main() {
  // Testing Book and FictionBook classes
  Book book = Book(title: '1984', author: 'George Orwell', numberOfPages: 328);
  book.bookDetails();
  print(book.toJson());

  FictionBook fictionBook = FictionBook(
      title: 'Dune',
      author: 'Frank Herbert',
      numberOfPages: 412,
      genre: 'Science Fiction');
  fictionBook.bookDetails();
  print(fictionBook.toJson());

  // Testing calculateArea function
  print('Rectangle area: ${calculateArea(length: 5.0, width: 3.0)}');
  print('Circle area: ${calculateArea(length: 3.0, shape: 'circle')}');

  // Testing User class
  User user1 = User(name: 'Alice', age: 25, email: 'alice@example.com');
  user1.printUserDetails();
  
  User user2 = User(name: 'Bob', age: null, email: null);
  user2.printUserDetails();
}

class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;

  Book({required this.title, required this.author, required this.numberOfPages});

  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'numberOfPages': numberOfPages,
    };
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook({
    required String title,
    required String author,
    required int numberOfPages,
    required this.genre,
  }) : super(title: title, author: author, numberOfPages: numberOfPages);

  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre');
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['genre'] = genre;
    return json;
  }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson();
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

double calculateArea({
  required double length,
  double width = 0.0,
  String shape = 'rectangle',
}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  }
  return length * width;
}
