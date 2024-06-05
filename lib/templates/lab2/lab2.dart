class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'numberOfPages': numberOfPages
    };
  }
}


class FictionBook extends Book {
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) 
      : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages, Genre: $genre');
  }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson();
}

double calculateArea({required double length, required double width, String shape = 'rectangle'}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  } else {
    return length * width;
  }
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    String ageString = age?.toString() ?? 'N/A';
    String emailString = email ?? 'N/A';
    print('Name: $name');
    print('Age: $ageString');
    print('Email: $emailString');
  }
}

void main() {
  Book book = Book('1984', 'George Orwell', 328);
  book.bookDetails();
  print(book.toJson());

  FictionBook fictionBook = FictionBook('Dune', 'Frank Herbert', 412, 'Science Fiction');
  fictionBook.bookDetails();


  print(calculateArea(length: 5.0, width: 10.0));
  print(calculateArea(length: 5.0, width: 0, shape: 'circle'));

  User user = User(name: 'Max', age: null, email: 'max@example.com');
  user.printUserDetails();
}

