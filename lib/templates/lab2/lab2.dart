void main() {
  Book book = Book('A byte of python', 'Chetan Swaroop',  251);
  print(book.bookDetails());

  FictionBook fictionBook = FictionBook('A byte of python', 'Chetan Swaroop',  251, 'Educational');
  print(fictionBook.bookDetails());

  print(book.toJson());

  print(calculateArea(length: 5, width: 10));
  print(calculateArea(length: 5, width: 0, shape: 'circle'));
  User user = User('Ravil Kazeev', 17, 'r.kazeev@innopolis.university');
  User user2 = User('Michael Jordan', null, null);
  user.printUserDetails();
  user2.printUserDetails();
}

class Book with JsonSerializable{
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  String bookDetails() {
    return 'Title: $title, Author: $author, Number of Pages: $numberOfPages';
  }

}

class FictionBook extends Book {

  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  String bookDetails() {
    return 'Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre';
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

double calculateArea({required double length, required double width, String shape = 'rectangle'}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  } else {
    return length * width;
  }
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, this.age, this.email);

  void printUserDetails(){
    print('Name: $name, Age: ${age ?? "N/A"}, Email: ${email ?? "N/A"}');
  }
}