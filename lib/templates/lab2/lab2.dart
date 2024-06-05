class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;

  Book(this.title,  this.author, this.numberOfPages); // Defaul constructor for initializing fields

  void printProperties(){
    print("Name: $title, Author: $author, Number of pages: $numberOfPages");
  }

}

class FictionBook extends Book{
  String genre;

  FictionBook(String title, String author, int pages, this.genre) : super(title, author, pages);

  @override
  void printProperties(){
    print("Name: $title, Author: $author, Number of pages: $numberOfPages, Genre: $genre");
  }

}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;

  Map toJson() {
    return {"title" : this.title, "author" : this.author, "numberOfPages" : this.numberOfPages};
  }
}

double calculateArea({double? length, double? width, String shape = "rectangle"}){
  double res = 0;
  const num pi = 3.14;

  if (shape == "rectangle"){

    res = length! * width!;

  } else if (shape == "circle"){

    res = pi * length! * length;
  }

  return res;
}

class User{
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

   void printUserDetails(){
    email = email ?? "N/A";
    if(age != null){
      print("Name: $name, Age:$age, Email: $email");
    }else{
      print("Name: $name, Age: N/A, Email: $email");
    }
   }
}

void main(){
  var b = Book("War and Peace", "Lev Tolstoy", 960);
  b.printProperties();
  var f = FictionBook("War", "Me", 1256, "Horror");
  f.printProperties();
  print(b.toJson());
  print(f.toJson());

  print(calculateArea( length: 10, width: 25));
  print(calculateArea( length: 10, shape: "circle"));

  var me = User(name: "Remal");
  me.printUserDetails();
}