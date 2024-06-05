

class Book with JsonSerializable{
  // your code here
  final String title;
  final String author;
  final int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);
  void bookDetails(){
    print("Title: $title\nAuthor: $author\nPages: $numberOfPages\n");
  }

}

class FictionBook extends Book{
  // your code here
  final String genre;
  FictionBook(super.title, super.author, super.numberOfPages, this.genre);
  @override
  void bookDetails() {
    // TODO: implement bookDetails
    super.bookDetails();
    print("Genre: $genre\n");
  }
}

mixin JsonSerializable {
  // your code here
  String? title;
  String? author;
  int? numberOfPages;

  Map<String, dynamic> toJson(){
    /*Map<String, dynamic> json = Map();
    json["title"] = book.title;
    json["author"] = book.author;
    json["numberOfPages"] = book.numberOfPages;*/
    return {
      "title": this.title,
      "author": this.author,
      "numberOfPages": this.numberOfPages
    };
  }
}

double calculateArea({required double length, required double width, String shape = "rectangle"}){
  // your code here
  if(shape == "circle"){
    return length*length*3.14;
  }
  return length*width;
}

class User{
  // your code here
  String name="";
  int? age;
  String? email;
  User({required this.name, this.age, this.email}){}
  void printUserDetails(){
    dynamic loc_age = this.age ?? "N/A";
    String loc_email = this.email ?? "N/A";
    print("Name: $name Age: $loc_age Email: $loc_email\n");
  }
}
