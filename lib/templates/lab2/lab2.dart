class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;
  
  Book(this.title, this.author, this.numberOfPages);

  void bookDetails(){
    print('$title, $author, $numberOfPages');
  }

}

class FictionBook extends Book{
  String genre;
  FictionBook(this.genre) : super('', '', 0);
  @override
  void bookDetails(){
    print('$title, $author, $numberOfPages, $genre');
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map <dynamic, dynamic> toJson(){
    Map map = {'Title' : title, 'Author' : author, 'Number of Pages' : numberOfPages};
    return map;
  }
}

double calculateArea(double length, double width, String shape){
  double area = 0.0;
  if(shape == 'circle'){
    area = 3.14 * length * length;
  }
  else if (shape == 'rectangle'){
    area = length * width;
  }
  return area;
}

class User{
  String name;
  int? age;
  String? email;

  User(this.name, this.age, this.email);

  void printUserDetails(){
    var agePrint = age ?? 'N/A';
    var emailPrint = email ?? 'N/A';
    print('Name: $name Age: $agePrint Email: $emailPrint');
  }
}

void main(){
  Book book = Book('Title', 'Author', 888);
  book.bookDetails();
}
