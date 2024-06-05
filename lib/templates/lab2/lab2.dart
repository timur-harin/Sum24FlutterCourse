class Book with JsonSerializable{
  final String title;
  final String author;
  final int numberOfPages;
  Book(this.title,this.author,this.numberOfPages);
  void bookDetails(){
    print("Title: "+title+" Author: "+author+" pages: "+numberOfPages.toString());
  }
}

class FictionBook extends Book{
  String genre;
  FictionBook(super.title,super.author,super.numberOfPages,this.genre);
  @override
  void bookDetails() {
    print("Title: "+title+" Genre: "+genre+" Author: "+author+" pages: "+numberOfPages.toString());
  }
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  Map<String,dynamic> toJson(){
      return{
        "title ":this.title,
        "author ":this.author,
        "numberOfPages ":this.numberOfPages,
              };
  }
}

double calculateArea({required double length, required double width, String shape = "rectangle"}) {
  double area;
  switch (shape.toLowerCase()) {
    case "triangle":
      area = length * width/2;
      break;
    case "circle":
      area = 3.14 * length * length;
      break;
    default:
      area = length * width;
      break;
  } 
  return area;
}


class User {
  String name;
  int? age;
  String? email; 

  User({
    required this.name,
    this.age,
    this.email,
  });
  

  void printUserDetails() {
    String age2 = "";
    String email2="";
    if(age==null){
       age2="N/A";
    }else{
     age2=age.toString();
    }
    if(email==null){
       email2="N/A";
    }else{
       email2=email.toString();
    }
    print("Name: " +name+" Age: "+age2+" Email: "+email2);
  }
}
void main(){
  Book kol= Book('Kolobok', 'Pushkin', 10);
  kol.bookDetails();
  FictionBook kol2= FictionBook('Kolobok', 'Pushkin', 10,'Skazka',);
  kol2.bookDetails();
  print(kol.toJson());
  print(calculateArea(length: 4.0, width: 3.0,shape: "triangle"));
  User us=User(name: "Karim",age: 12, email: "@mail.ru");
  us.printUserDetails();
}
