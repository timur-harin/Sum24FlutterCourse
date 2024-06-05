class Book with JsonSerializable {
  final String title;
  final String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print(
        'The name of the book is $title. The author is $author. The number of pages is $numberOfPages.');
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  @override
  void bookDetails() {
    print(
        'The name of the book is $title. The author is $author. The number of pages is $numberOfPages. The genre is $genre.');
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberofPages;
  Map<String, dynamic> toJson() {
    return {'title': title, 'author': author, 'number of pages': numberofPages};
  }
}

double calculateArea(double length, double width,
    [String shape = 'rectangle']) {
  if (shape == 'rectangle') {
    return length * width;
  }
  if (shape == 'circle') {
    return 3.14 * length * length;
  }
  return (length * width) / 2; // triangle
}

class User {
  String name;
  int? age;
  String? email;
  User(this.name, this.age, this.email);

  void printUserdetails() {
    print('Name: $name');
    if (age == null) {
      print('Age: N/A');
    } else {
      print('Age: $age');
    }

    if (email == null) {
      print('Email: N/A');
    } else {
      print('Email: $email');
    }
  }
}

void main() {
  Book book = Book('Martin Iden', 'Jack London', 312);
  book.bookDetails();

  FictionBook fbook =
      FictionBook('Sherlock Holmes', 'Arthur Conan Doyle', 123, 'Crime');
  fbook.bookDetails();

  print(book.toJson());

  print(calculateArea(2, 3));
  print(calculateArea(3, 1, 'circle'));

  User user = User('George', 23, null);
  user.printUserdetails();
}
