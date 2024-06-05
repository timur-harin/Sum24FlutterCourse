
import 'dart:ffi';

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);
  toJson(); 

  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages');
  }
}


class FictionBook extends Book {
  String? genre;
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  void bookDetails() {
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages, Genre: $genre');
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
  int? age;
  String? email;
  String name;
  User(this.name, this.age, this.email);
  void printUserDetails() {
    print('Name: $name');
    print('Age: ${age ?? 'N/A'}');
    print('Email: ${email ?? 'N/A'}');
  }

}

void main (){
  Book book = Book("Poema o vmyatine", "Ivan Makarov", 47);
  book.bookDetails();

  FictionBook fiction = FictionBook("Poema o vmyatine", "Ivan Makarov", 47, "Action");
  fiction.bookDetails();

  print(book.toJson());

  print(calculateArea(length: 7, width: 7));
  print(calculateArea(length: 7, width: 7, shape: "circle"));

  User user1 = User("Ivan Makarov", 18, "Email");
  User user2 = User("John Johnson", 33, "Email");
  user1.printUserDetails();
  user2.printUserDetails();
}
