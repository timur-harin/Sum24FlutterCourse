

void main() {
  FictionBook fictionBook = FictionBook('Lean Startup', 'Eric Ries', 366, 'Non-fiction');
  //var book1 = Book('Lean Startup', 'Eric Ries', 366);
  fictionBook.bookDetails();
  print('\n');
  print(fictionBook.toJson());

}

class Book with JsonSerializable  {
  String title;
  String author;
  int numberOfPages;
  
  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title');
    print('Author: $author');
    print('Number of pages: $numberOfPages');
  }
}

class FictionBook extends Book{
  String genre;

  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  
  @override 
  void bookDetails() {
    super.bookDetails();
    print('Genre: $genre');
  }
}

mixin JsonSerializable {

  String get title;
  String get author;
  int get numberOfPages;
  
  Map<String, dynamic> toJson() => {
    'title' : title,
    'author': author,
    'numberofPages': numberOfPages,
  };
}

double calculateArea(double length, double width, String shape){
  //Rectangle
  double area;
  if(shape == 'circle') {
    area = 3.14 * length * length;
  } else {
    area = length * width;
  }
  return area;
}

class User{
  String name;
  int? age;
  String? email;
  
  User(this.name, this.age, this.email);

  void printUserDetails() {
    print('Name: $name');
    print('Age: ${age ?? 'N/A'}');
    print('Email: ${email ?? 'N/A'}');

  }
}



// git add.
// git commit -m "comlete lab2"
// git push