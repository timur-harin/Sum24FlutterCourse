void main(){
  var book = Book('Capibara', 'Valeria', 165);
  book.bookDetails();

  var fiction = FictionBook('Capibara', 'Valeria', 165, 'Novel');
  fiction.bookDetails();

 print(book.toJson());
 print(calculateArea(length: 20, width: 30));
 print(calculateArea(length: 29,  width: 30, shape: "circle"));

 var user = User(name: 'Valeriia', age: 19, email: 'v.neganova@inn.un' );
 user.printUserDetails();
 var anotheruser = User(name: 'Valeriia',  email: 'v.neganova@inn.un' );
 
anotheruser.printUserDetails();

}

class Book with JsonSerializable {
  final String title;
  final String author ;
  final int numOfPage ;

   //constructor
   Book(this.title, this.author, this.numOfPage);

   void bookDetails(){
    print('Title : $title, Author : $author, Number of page : $numOfPage.');
   
   }

}

class FictionBook extends Book{
  String genre;

FictionBook(title, author, numOfPage, this.genre) : super(title, author, numOfPage);   

@override
  void bookDetails(){
    print('Book $title written by author $author in genre $genre and has $numOfPage num of pages.');
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numOfPage;

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map["title"] = this.title;
    map["author"] = this.author;
    map["number of pages"] = this.numOfPage;
    return map;
    }

}

double calculateArea({required double length, required double width, String shape = "rectangle"}){
  if(shape.toLowerCase() == "rectangle"){
    return length * width;
  } else if(shape.toLowerCase() == "circle"){
    return 3.14 * length * length;
  } else{
    return 0;
  }
}


class User{
   String name;
   int? age;
   String? email;

   User({required this.name, this.age, this.email});

   void printUserDetails(){
    print('Name $name, age ${age ??'N/A'}, email ${email ??'N/A'}');
   }
}

