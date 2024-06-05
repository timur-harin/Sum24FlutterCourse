class Book {
  String title;
  String author;
  int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);
  void bookDetails() { 
      // ignore: avoid_print
      print("title: [$title], author: [$author], pages: [$numberOfPages]");
    }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  
  @override
  void bookDetails() {
    // ignore: avoid_print
    print("title: [$title], author: [$author], pages: [$numberOfPages], genre: [$genre]");
  }
}

mixin JsonSerializable on Book {
  // your code here
  Map<String, dynamic> toJson() {
    // your code here
    return {"title": super.title,
      "author": super.author,
      "numberOfPages": super.numberOfPages};
  }
}

class UpdatedBook extends Book with JsonSerializable {
  UpdatedBook(super.title, super.author, super.numberOfPages);
}

double calculateArea({required double lenght, required double width, String? shape = "rectangle"}) {
  switch (shape) {
    case "rectangle":
      return lenght * width;
    case "circle":
      return 3.14 * lenght * lenght;
    default:
      return 0.0;
  }
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, [this.age, this.email]);

  void printUserDetails() {
    // ignore: avoid_print
    print("name: [$name], age: [${age ?? "N/A"}], email: [${email ?? "N/A"}]");
  }
}

void main() {
  // exercise 1
  Book b = Book("book1", "niyaz", 123);
  print("book1 description");
  b.bookDetails();

  // exercise 2
  FictionBook f = FictionBook("book2", "dima", 456, "comedy");
  print("book2 description");
  f.bookDetails();

  // exercise 3
  UpdatedBook u = UpdatedBook("book3", "dima", 456);
  print("book3 description");
  u.bookDetails();
  print(u.toJson());

  // exercise 4
  print(calculateArea(lenght: 10.0, width: 1.0));
  print(calculateArea(lenght: 10.0, width: 4.0, shape: "circle"));
  

  // exercise 5
  User u1 = User("dima", 25, "<EMAIL>");
  User u2 = User("dima", 25);
  User u3 = User("dima");
  u1.printUserDetails();
  u2.printUserDetails();
  u3.printUserDetails();
}