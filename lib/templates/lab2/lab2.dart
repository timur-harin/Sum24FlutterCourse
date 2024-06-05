class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;
  
  Book(this.title, this.author, this.numberOfPages);
 void bookDetails(){
  print("$title, $author, $numberOfPages");
 } 
  }

class FictionBook extends Book with JsonSerializable {
  String genre;

  FictionBook(String title,  String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);
  @override
  void bookDetails(){
    print("$title, $author, $numberOfPages, $genre");
  }
}

mixin JsonSerializable {
String get title;
String get author;
int get numberOfPages;

Map<String, dynamic> toJson() => {
  'title': title,
  'author': author,
  'numberOfPages': numberOfPages,
};
}


double calculateArea({required length, required width, String shape = "rectangle"}) {
if (shape == 'circle') {
    return 3.14 * length * length; 
  } else {
    return length * width; 
  }
}

class User{
  String name;
  int? age;
  String? email;
  User({required this.name, this.age, this.email});

  void printUserDetails() {
    String ageString = age?.toString() ?? 'N/A';
    String emailString = email ?? 'N/A';
    print('Name: $name');
    print('Age: $ageString');
    print('Email: $emailString');
  }
}
