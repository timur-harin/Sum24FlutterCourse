class Book with JsonSerializable{
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails(){
    print("Title: $title, Author: $author, Number of pages: $numberOfPages");
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print("Genre: $genre");
  }

}

mixin JsonSerializable{

  String? title;
  String? author;
  int? numberOfPages;
  
  Map <String, dynamic> toJson() {
    return {
      "title": title,
      "author": author,
      "numberOfPages": numberOfPages
    };
  }
}

double calculateArea({required double length, required double width, String? shape = 'rectangle'}) {
  if (shape == 'rectangle') {
    return length * width;
  } else if (shape == 'square') {
    return length * width; 
  } else if (shape == 'circle') {
    return 3.14 * length * length;
  }
  return 0.0;
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDeteils() {
    print("Name:[$name]");
    print("Age: [${age ?? "N/A"}]");
    print("Email: [${email ?? "N/A"}]");
  }
}

void main () {
  Book book = Book("title", "author", 100);
  book.bookDetails();

  FictionBook fictionBook = FictionBook("title", "author", 100, "Roman");
  fictionBook.bookDetails();

  print(calculateArea(length: 10, width: 20));
  print(calculateArea(length: 10, width: 20, shape: 'square'));
  print(calculateArea(length: 10, width: 20, shape: 'circle'));

  User user = User(name: "John", age: 30, email: "G5a5m@example.com");
  user.printUserDeteils();

  User user2 = User(name: "Jane");
  user2.printUserDeteils();
}