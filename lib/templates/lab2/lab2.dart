class Book with JsonSerializable {
  final String? title; 
  final String? author; 
  final int? numberOfPages;

  Book(this.title, this.author, this.numberOfPages);

  void bookDetails(){
    print ("Title: $title, Author: $author, Number of pages: $numberOfPages");
  }

}

class FictionBook extends Book {

   String? genre;

  FictionBook(String title, String author, int numberOfPages, String genre) : super(title, author, numberOfPages){
    this.genre = genre;
  }

  @override
  void bookDetails() {
    print ("Title: $title, Author: $author, Number of pages: $numberOfPages, genre: $genre");
  }
}

mixin JsonSerializable {
  String? title; 
  String? author; 
  int? numberOfPages;


  Map<String, dynamic> toJson() => {
    'title': title,
    'author': author,
    'numberOfPages': numberOfPages
  };
}



  calculateArea(double lenght, double width,{String shape = "rectangle"}){  
    if(shape == "circle"){
      return 3.14 * lenght * lenght;
  
    }
    return lenght * width;
  
  }

class User{
  String name;
  int? age;
  String? email;

  User(this.name, this.age, this.email);

  printUserDetails(){
   String userName = name ?? "N/A";
   String userAge = age?.toString() ?? "N/A";
   String userEmail = email ?? "N/A";
   print("Name: $userName");
   print("Age: $userAge");
   print("Email: $userEmail");
  }
}

void main() {
  var story = Book("The Hobbit", "J.R.R. Tolkien", 295);
  story.bookDetails();
  print(story.toJson());

  var fiction = FictionBook("The Hobbit", "J.R.R. Tolkien", 295, "Fantasy");
  fiction.bookDetails();  


  print(calculateArea(10, 20));
  print(calculateArea(10, 20, shape: "circle"));


  var user = User("John", 30, "qKwXU@example.com");
  user.printUserDetails();



}