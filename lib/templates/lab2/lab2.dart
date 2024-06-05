class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print("Title: $title, Author: $author, Number of pages: $numberOfPages\n");
  }
}

class FictionBook extends Book {
  String genre;

  FictionBook(String title, String author, int numberOfPages, this.genre)
      : super(title, author, numberOfPages);
      
    
  @override
  void bookDetails() {
    print('Title: $title, Author: $author, Number of pages: $numberOfPages, Genre: $genre\n');
  }
}

mixin JsonSerializable {

  String? title;
  String? author;
  int? numberOfPages;
  Map toJson() {
    var json = {
      'title': title,
      'author': author,
      'numberOfPages': numberOfPages};
    return json;
  }
}

double calculateArea({double? length, double? width, String? shape = "rectangle"}) {
  if(shape == "circle"){
    if (length == null) {
      throw Exception("Length must be provided");
    }
    return length * length * 3.14;
  }

  if (length == null || width == null) {
      throw Exception("Length and width must be provided");
    }
  return width * length;
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails(){
    print("Name: [$name]]");
    print("Age: [${age ?? "N/A"}]");
    print("Email: [${email ?? "N/A"}]");
  }
}

void main(){
  var book = Book("King", "N. Mackiovelly", 350);
  book.bookDetails();

  var book2 = FictionBook("King", "N. Mackiovelly", 350, "tractation");
  book2.bookDetails();

  print(book2.toJson());
  print("\n");


  print(calculateArea(length: 12, width: 6));
  print(calculateArea(shape: "circle", length: 2));
  print("\n");

  var user = User(name: "John");
  user.printUserDetails();

  print("\n");
  var user2 = User(name: "Rail", age: 19);
  user2.printUserDetails();

  print("\n");
  var user3 = User(name: "Amir", email: "amir@example.com");
  user3.printUserDetails();
}
