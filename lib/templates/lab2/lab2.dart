
class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    if (title != null && author != null && numberOfPages != null) {
      print('Details:\ntitle: $title, author: $author, number of pages: $numberOfPages');
    } else {
      print('No details...');
    }
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);



  @override
  void bookDetails() {
    print('Details:\ntitle: $title, author: $author, number of pages: $numberOfPages, genre: $genre.');
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  toJson() {
    var map = {"title" : this.title, "author" : this.author, "Number of pages" : this.numberOfPages};
    return map;
  }
}

double calculateArea({required double length, required double weight, String shape = "rectangle"}){

  double S;
  if(shape == "circle") {
    S = 3.14 * length * length;
  } else if (shape == "rectangle") {
    S = length * weight;
  } else {
    S = 0;
  }
  return S;
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, {this.age, this.email});

  void printUserDetails() {
    print('Name: [$name]\nAge: [${age ?? "N/A"}]\nEmail: [${email ?? "N/A"}]');
  }
}

int main(){
  Book newBook = Book("Anna Karenina", "L. Tolstoy", 600);
  newBook.bookDetails();

  FictionBook newFictionBook = new FictionBook("War and piece", "L. Tolstoy", 100000000000000000, "Novel");
  newFictionBook.bookDetails();

  print(newBook.toJson());

  print(calculateArea(length: 18, weight: 12, shape: "circle"));
  print(calculateArea(length: 18, weight: 12));

  User user = User("Sergey", age: 18);
  user.printUserDetails();
  return 0;
}
