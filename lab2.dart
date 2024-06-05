
class Book with ConvertibleToJson {
  String title;
  String author;
  int pageCount;

  Book(this.title, this.author, this.pageCount);

  void displayBookInfo() {
    print('Title: $title, Author: $author, Page Count: $pageCount');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'pageCount': pageCount
    };
  }
}

class Novel extends Book {
  String category;

  Novel(String title, String author, int pageCount, this.category) 
      : super(title, author, pageCount);

  @override
  void displayBookInfo() {
    print('Title: $title, Author: $author, Page Count: $pageCount, Genre: $category');
  }
}


mixin ConvertibleToJson {
  Map<String, dynamic> toJson();
}

double computeArea({required double length, required double width, String shape = 'rectangle'}) {
  const double pi = 3.14;
  if (shape == 'circle') {
    return pi * length * length;
  } else {
    return length * width;
  }
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void showUserInfo() {
    String ageInfo = age?.toString() ?? 'N/A';
    String emailInfo = email ?? 'N/A';
    print('Name: $name');
    print('Age: $ageInfo');
    print('Email: $emailInfo');
  }
}

void main() {

  Book myBook = Book('Brave New World', 'Aldous Huxley', 311);
  myBook.displayBookInfo();
  print(myBook.toJson());


  Novel myNovel = Novel('The Hobbit', 'J.R.R. Tolkien', 310, 'Fantasy');
  myNovel.displayBookInfo();


  print(computeArea(length: 7.0, width: 14.0)); // Rectangle area
  print(computeArea(length: 7.0, width: 0, shape: 'circle')); // Circle area

  User newUser = User(name: 'Bob', age: null, email: 'bob@example.com');
  newUser.showUserInfo();
}
