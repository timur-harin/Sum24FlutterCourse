class Book with JsonSerializable{
  // your code here
  final String title, author;
  final int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);
  void bookDetails() => print('Title: $title, Author: $author, Pages: $numberOfPages');
}

class FictionBook extends Book {
  // your code here
  String genre;
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  
  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Pages: $numberOfPages, Genre: $genre');
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  // your code here
  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'author': this.author,
      'numberOfPages': this.numberOfPages,
    };
  }
}

double calculateArea({required double length, required double width, String shape = 'rectangle'}) {
  // your code here
  if (shape == 'circle') {
    return 3.14 * length * length;
  } else {
    return length * width;
  }
}

class User{
  // your code here
  String name;
  int? age;
  String? email;
  User({required this.name, this.age, this.email});
  void printUserDetails() {
    String age1 = age.toString();
    if (age == null) age1 = "N/A";
    String email1 = email ?? "N/A";
    print('Name: $name\nAge: $age1\nEmail: $email1');
  }
}

void main() {
  var book = Book('The Great Gatsby', 'F. Scott Fitzgerald', 176);
  // call of the method bookDetails
  book.bookDetails();

  var json = book.toJson();
  print(json);

  print(calculateArea(length: 2, width: 3, shape: 'circle'));

  User user = User(name: "djcj", age: null, email: null);
  user.printUserDetails();
}
