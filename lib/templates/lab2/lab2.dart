class Book with JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  Book(this.title, this.author, this.numberOfPages);
  void bookDetails() {
    print("title: $title\nauthor: $author\nnumber of pages: $numberOfPages");
  }

}

class FictionBook extends Book {
  String genre;
  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);
  @override
  void bookDetails() {
    print("genre: $genre\ntitle: $title\nauthor: $author\nnumber of pages: $numberOfPages");
  }
}

mixin JsonSerializable {
  // your code here
}

double calculateArea(){
  // your code here
}

class User {
  String name = "";
  int? age;
  String? email;
  User({required String name, int? age, String? email}) {
    this.name = name;
    this.age = age;
    this.email = email;
  }
  void printUserDetails() {
    dynamic a = age ?? "N/A";
    dynamic b = email ?? "N/A";
    print("Name: $name Age: $a email Email: $b");
  }
}

void main() {
  Book book = Book("Harry Potter", "JK Rowling", 400);
  book.bookDetails();


  FictionBook fictionBook = FictionBook("It", "Stiven King", 100, "Horror");
  fictionBook.bookDetails();
  print(calculateArea(length: 5, width: 10));
  User user = User(name: "John", age: 25, email: "0WJpj@example.com");
  user.printUserDetails();
}