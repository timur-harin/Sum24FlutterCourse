class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Book info: \n Title: $title \n Author: $author \n Number of pages: $numberOfPages");
  }
}


class FictionBook extends Book {
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    print("Book info: \n Title: $title \n Author: $author \n Number of pages: $numberOfPages \n Genre: $genre");
  }
}


mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  
  Map toJson() {
    return {
      'title': title,
      'author': author,
      'numberOfPages': numberOfPages
    };
  }
}

double calculateArea({double? length, double? width, String shape = "rectangle"}) {
  if (shape == "rectangle" && length != null && width != null) {
    return length * width;
  } else if (shape == "circle" && length != null) {
    return 3.14 * length * length;
  } else {
    print("Please provide length and width");
    return 0.0;
  }
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print("Name: $name Age: ${age ?? "N/A"} Email: ${email ?? "N/A"}");
  }
}

void main() {
  // Task 1: Classes
  Book book = Book("The Great Gatsby", "F. Scott Fitzgerald", 180);
  book.bookDetails();

  // Task 2: Inheritance
  Book fictionBook = FictionBook("Harry Potter", "J. K. Rowling", 400, "Fantasy");
  fictionBook.bookDetails();

  // Task3: Mixins
  print(book.toJson());
  
  // Task 4: Function
  print(calculateArea(width: 10.0, length: 20.0, shape: 'rectangle'));
  print(calculateArea(length: 10.0, shape: 'circle'));
  
  // Task 5: Null-safety
  User user = User(name: "John", age: 20, email: "johndoe@.com");
  user.printUserDetails();
}
