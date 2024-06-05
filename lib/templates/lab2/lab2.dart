class Book with JsonSerializable{
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title, author: $author, pages: $numberOfPages");
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails() {
    print("Title: $title, author: $author, pages: $numberOfPages, genre: $genre");
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;


  Map<String?, String?> toJson() {
    Map<String?, String?> json = {
      "title": title,
      "author": author,
      "pages": numberOfPages.toString()
    };
    return json;
  }


  // your code here
}

double calculateArea({required double width, required double length, String shape = "rectangle"}){
  if (shape == "rectangle") {
    return width*length;
  } else if (shape == "circle") {
    return 3.14*length*length;
  } else {
    return 0;
  }
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, [this.age, this.email]);

  void printUserDetails() {
    print("Name: $name Age: ${age ?? "N\\A"} Email: ${email ?? "N\\A"}");
  }
}

void main() {
  Book book = Book("title", "John Doe", 200);
  book.bookDetails();

  FictionBook fiction = FictionBook("title", "JohnDoe", 123, "fiction");
  fiction.bookDetails();

  print(book.toJson());

  print(calculateArea(width: 5.0, length: 4.0));
  print(calculateArea(width: 5.0, length: 4.0, shape: "circle"));

  User user1 = User("John Doe");
  User user2 = User("John Doe", 25, "some email");
  User user3 = User("John Doe", 25);
  user1.printUserDetails();
  user2.printUserDetails();
  user3.printUserDetails();

}