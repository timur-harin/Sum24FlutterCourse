class Book with JsonSerializable{
  String title; 
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void BookDetails() {
    print("Title: $title, Author: $author, Number of Pages: $numberOfPages");
  }

  @override
  Map toJson() {
    return {
      "title": title,
      "author": author,
      "numberOfPages": numberOfPages
    };
  }
}

class FictionBook extends Book{
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);
  
  @override
  void BookDetails() {
    print("Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre");
  }
}

mixin JsonSerializable {
  Map toJson();
}

double calculateArea({required double length, required double width, String shape = 'rectangle'}) {
  if (shape == 'rectangle') {
    return length * width;
  }
  if (shape == 'circle') {
    return 3.14 * (length * length);
  }
  return 0.0;
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print("Name: $name, Age: ${age ?? "N/A"}, Email: ${email ?? "N/A"}");
  }
}

void main() {
  Book book = Book("War and Peace", "Leo Fat", 1800);
  book.BookDetails();

  FictionBook fictionBook = FictionBook("React for beginers", "Someone", 300, "Education");
  fictionBook.BookDetails();

  print(book.toJson());

  print(calculateArea(length: 10, width: 0, shape: 'circle'));

  User user = User(name: "John Smith", age: 40);

  user.printUserDetails();
}







