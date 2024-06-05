void main () {
  var book1 = Book('Harry Potter', 'Rowling', 100);
  book1.bookDetails();
  var fitionBook1 = FictionBook('Harry Potter', 'Rowling', 100, 'fantasy');
  fitionBook1.bookDetails();
  print(book1.toJson());
  print(calculateArea(10, 20, shape: 'circle'));
  var user1 = User(name: 'Makar', age: 19, email: 'makar@gmai.com');
  user1.printUserDetails();

}

class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);


  void bookDetails() {
    print('$author, $numberOfPages, $title');
  } 
}

class FictionBook extends Book {
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);

  @override
  void bookDetails() {
    print('$author, $numberOfPages, $title, $genre');
  }
  
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'author': this.author,
      'numberOfPages': this.numberOfPages,
    };
  }
}

double calculateArea(double length, double width, {String shape = 'rectagle'}) {
  if (shape == 'circle') {
    return 3.14 * length * length;
  }
  else {
    return length * width;

  }
  
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print("Name: $name");
    if (age == null) {
      print("N/A");
    } else {
      print("Age: $age");
    }
    if (email == null) {
      print("N/A");
    } else {
      print("Email: $email");
    }
  }
}
