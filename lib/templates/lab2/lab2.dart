class Book with JsonSerializable{
  final String title;
  final String author;
  final int numberOfPages;
  Book({required this.title, required this.author, required this.numberOfPages});
  bookDetails(){
    print("Title: $title");
    print("Author: $author");
    print("Number of pages: $numberOfPages");
  }
}

class FictionBook extends Book {
  String genre;
  FictionBook({required super.title, required super.author, required super.numberOfPages, required this.genre});

  @override
  bookDetails(){
    super.bookDetails();
    print("Genre: $genre");
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  Map toJson(){
    return {
      "title": title,
      "author": author,
      "numberOfPages": numberOfPages
    };
  }
}

double calculateArea({required double width, required double height, String shape = "rectangle"}){
  if (shape == 'rectangle'){
    return width * height;
  }
  else if (shape == 'circle'){
    return 3.14 * width * width;
  }
  else {
    return -99999999;
  }

}

class User{
  String name;
  int? age;
  String? email;
  User({required this.name, this.age, this.email});
  void printUserDetails(){
    print("Name: $name Age: ${age ?? 'N/A'} Email: ${email ?? 'N/A'}");
  }
}

void main() {
  Book b;
  b = Book(title: "Легенды абобы", author: "абоба", numberOfPages: 69);
  b.bookDetails();
  print('----------------');
  FictionBook fb;
  fb = FictionBook(title: "Легенды абобы", author: "абоба", numberOfPages: 69, genre: "страдания");
  fb.bookDetails();
  print('----------------');
  print(b.toJson());
  print('----------------');
  print(calculateArea(width: 10, height: 20));
  print(calculateArea(width: 3, height: 5, shape: "circle"));
  print('----------------');
  User u1 = User(name: "Абоба", age: 69, email: "aboba@gmail.com");
  User u2 = User(name: "Абоба", age: 69);
  User u3 = User(name: "Абоба");
  u1.printUserDetails();
  u2.printUserDetails();
  u3.printUserDetails();

}