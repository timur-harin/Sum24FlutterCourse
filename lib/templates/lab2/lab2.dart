class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('$title $author $numberOfPages');
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);

  @override
  void bookDetails() {
    super.bookDetails();
    print('Genre: $genre');
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
      'numberOfPages': numberOfPages
    };
  }
}

double calculateArea(double length, double width, {String shape = 'rectangle'}) {
  return shape == 'circle' ? 3.14 * length * length : length * width;
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    String ageStr = age?.toString() ?? "N/A";
    String emailStr = email ?? "N/A";
    print("Name: $name Age: $ageStr Email: $emailStr");
  }
}

void main() {
  Book book = Book("1984", "George Orwell", 328);
  book.bookDetails();
  FictionBook fictionBook = FictionBook("The Lord of the Rings", "J.R.R. Tolkien", 1178, "Fantasy");
  fictionBook.bookDetails();
  print(book.toJson());

  User user1 = User(name: "Alice", age: 25, email: "alice@example.com");
  User user2 = User(name: "Bob");

  user1.printUserDetails(); 
  user2.printUserDetails();
}