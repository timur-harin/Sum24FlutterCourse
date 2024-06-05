// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);
  void bookDetails() {
    print('Title: $title');
    print('Author: $author');
    print('Number of Pages: $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print('Genre: $genre');
  }
}

mixin JsonSerializable {
  String? title, author;
  int? numberOfPages;
  Map toJson(Book book) {
    return {
      'title': book.title,
      'author': book.author,
      'numberOfPages': book.numberOfPages
  };
}
}


double calculateArea({double? length, double? width, String shape = 'rectangle'}) {
if(shape == "circle"){
    if (length == null) {
      throw Exception("Length must be provided");
    }
    return length * length * 3.14;
  }

  if (length == null || width == null) {
      throw Exception("Length and width must be provided");
    }
  return width * length;
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
  Book book = Book('The Catcher in the Rye', 'J.D. Salinger', 300);
  book.bookDetails();

  FictionBook fictionBook = FictionBook('Lord of the Rings', 'J.R.R. Tolkien', 520, 'Fantasy');
  fictionBook.bookDetails();

  print(book.toJson(book));

  double rectArea = calculateArea(length: 10, width: 10);
  print('Rectangle area: $rectArea');

  double circArea = calculateArea(length: 3, width: null, shape: 'circle');
  print('Circle area: $circArea');

  double circArea1 = calculateArea(length: 3, width: 7, shape: 'circle');
  print('Circle area: $circArea1');

  try {
    calculateArea(length: 5, width: 2, shape: 'triangle');
  } catch (e) {
    print('Invalid shape: $e');
  }

  User user = User(name: 'John Doe', age: 52, email: 'johndoe@gmail.com');
  user.printUserDetails();
}
