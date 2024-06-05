class Book implements JsonSerializable{
   String title;
   String author;
   int numberOfPages;
   Book(this.title, this.author, this.numberOfPages);

   void bookDetails(){
    print('Title: $title, Author: $author, Number of Pages: $numberOfPages');
   }

   @override
   Map<String, dynamic> toJson(){
    return{
      "title": title,
      "author" : author, 
      'numberOfPages': numberOfPages,
    };
   }
}

class FictionBook extends Book {
   String genre;

   FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);

   @override
   void bookDetails(){
    print('Title: $title, Author: $author, Genre: $genre,  Number of Pages: $numberOfPages');
   }
}

mixin JsonSerializable {
  Map<String, dynamic> toJson();
}

double calculateArea({required length, required width, String shape='rectangle'}){
  if (shape == 'circle') {
    return 3.14 * length * length; 
  }
  return length * width;
}

class User{
  String name;
  int? age;
  String? email;
  User({required this.name, this.age, this.email});

  void printUserDetails() {
    String ageStr = age?.toString() ?? 'N/A';
    String emailStr = email ?? 'N/A';
    print('Name: $name, Age: $ageStr, Email: $emailStr');
  }


  
}
