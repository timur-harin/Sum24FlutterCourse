class Book with JsonSerializable {
  String? title;
  String? author;
  int? numOfPages;

  Book(this.title, this.author, this.numOfPages);

  void bookDetails() {
    print('title: $title, author: $author, numOfPages: $numOfPages');
  }
}

class FictionBook extends Book {
  String? genre;
  

  FictionBook(String title, String author, int numOfPages, String genre) : super(title, author, numOfPages) {
    this.genre = genre;
  }

  @override
  void bookDetails() {
    print('title: $title, author: $author, numOfPages: $numOfPages, genre: $genre');
  }


}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numOfPages;

  Map<String, dynamic> toJson() {
      return {
        'title': this.title,
        'author': this.author,
        'numOfPages': this.numOfPages
      };
  }
}

double calculateArea(double length, double width, {String shape = "rectangle"}) {
  if (shape == "rectangle") {
    return length * width;
  } else if (shape == "circle") {
    return 3.14 * (length * length);
  } else {
    return 0;
  }
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, this.age, this.email);

  void printUserDetails() {
    print('Name: $name');
    if (age != null) {
      print('Age: $age');
    } else {
      print('N/A');
    }
    if (email != null) {
      print('Email: $email');
    } else {
      print('N/A');
    }
  }
}

void main(){
  Book book = Book('BestBook', 'Amir', 111);
  book.bookDetails();

  FictionBook fictionBook = FictionBook('BestFiction', 'Star', 222, 'roman');
  fictionBook.bookDetails();

  Map<String, dynamic> json = fictionBook.toJson();
  print(json);

  double area = calculateArea(10, 20);
  print('Area: $area');

  double area2 = calculateArea(10, 20, shape: "circle");
  print('Area: $area2');

  User user = User('Amir', 18, 'a@a.com');
  user.printUserDetails();

  User user2 = User('Adel', null, 'a@b.com');
  user2.printUserDetails();

  User user3 = User('Rustam', 11, null);
  user3.printUserDetails();
}