class Book {
  // your code here
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetailes () {
    print('The book $title written by $author contains $numberOfPages pages');
  }
}

class FictionBook extends Book{
  // your code here
  String? genre;

  FictionBook(super.title, super.author, super.numberOfPages);

  @override
  void bookDetailes () {
    print('The genre of the book is $genre');
  }
}

mixin JsonSerializable {
  // your code here
  String? title;
  String? author;
  int? numberOfPages;

  void toJson () {
    Map<String, dynamic> map = {"title": title, "author": author, "numberOfPages": numberOfPages};
    print(map);
  }
}

double calculateArea({double? length, double? width, String shape = "rectangle"}){
  // your code here
  double area = 0;
  double pi = 3.14;
  if (shape == "rectangle" && width != null && length != null) {
    area = length * width;
  } 
  if (shape == "circle" && length != null) {
    area = length * pi * length;
  }
  return area;
}

class User{
  // your code here
  String name;
  int? age;
  String? email;

  User ({required this.name, this.age, this.email});

  void printUserDetailes () {
    print('Name: $name Age: ' + (age ?? "N/A").toString() + ' Email: ' + (email ?? "N/A"));
  }
}
