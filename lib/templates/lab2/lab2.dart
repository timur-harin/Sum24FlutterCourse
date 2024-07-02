// class Book {
//   // your code here
//   String title;
//   String author;
//   int numberOfPages;

//   Book({required this.title, required this.author, required this.numberOfPages});

//   void bookDetails() {
//     print('Title: $title, Author: $author, Pages: $numberOfPages');
//   }
// }

class FictionBook extends Book {
  String genre;

  FictionBook({required String title, required String author, required int numberOfPages, required this.genre})
      : super(title: title, author: author, numberOfPages: numberOfPages);

  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages, Genre: $genre');
  }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson();
}

class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;

  Book({required this.title, required this.author, required this.numberOfPages});

  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages');
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

double calculateArea({required double length, required double width, String shape = 'rectangle'}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  }
  return length * width;
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
  Book book = Book(title: 'Harry Potter', author: 'J.K. Rowling', numberOfPages: 4100);
  book.bookDetails();
  FictionBook fictionBook = FictionBook(title: 'The Hobbit', author: 'J.R.R. Tolkien', numberOfPages: 310, genre: 'Fantasy');
  fictionBook.bookDetails();
  Book book2 = Book(title: 'The Little Prince', author: 'Antoine de Saint-Exupery', numberOfPages: 91);
  print(book.toJson());
  print('Rectangle area: ${calculateArea(length: 5.0, width: 3.0)}'); 
  print('Circle area: ${calculateArea(length: 3.0, width: 0, shape: 'circle')}');
  User user = User(name: 'Random Name', age: 30, email: 'random.name@example.com');
  user.printUserDetails();
  User user2 = User(name: 'Second RandomName');
  user2.printUserDetails();
  
}