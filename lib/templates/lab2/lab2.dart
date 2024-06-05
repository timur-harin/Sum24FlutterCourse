class Book with JsonSerializable{
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title, Author: $author, Number of pages: $numberOfPages"); 
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails() {
    print("Title: $title, Author: $author, Number of pages: $numberOfPages, Genre: $genre"); 
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  Map<String, dynamic> toJson() {
    return {
      "Title": title,
      "Author": author,
      "Number of pages": numberOfPages
    };
  }
}

double calculateArea({required lenght, required double width, String? shape = "Rectangle"}){
  if (shape == "Rectangle") {
    return lenght * width;
  } else if (shape == "Circle") {
    return 3.14 * lenght * lenght;
  } else {
    return 0;
  }
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print("Name: $name");

    if(age == null) {
      print("Age: N/A");
    } else {
      print("Age: $age");
    }

    String emailTemp = email ?? "N/A";

    print("Email: $emailTemp");
  }
}

void main() {
  Book book = Book("Hoh", "Lethal", 12);
  book.bookDetails();
  print(book.toJson());
  print(calculateArea(lenght: 3.5, width: 2));
  print(calculateArea(lenght: 6, width: 8, shape: "Circle"));
  User user = User(name: "Ahaha", email: "d.tskhe@innopolis.university");
  user.printUserDetails();
}
