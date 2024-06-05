class Book with JsonSerializable {
  String title;
  String author;
  int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);

  void bookDetails() {
    print('Title: $title');
    print('Author: $author');
    print('Number of Pages: $numberOfPages');
  }
}

class FictionBook extends Book{
  String genre;
  FictionBook(String title, String author, int numberOfPages, this.genre) : super(title, author, numberOfPages);

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

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'author': this.author,
      'numberOfPages': this.numberOfPages,
    };
  }
}

double calculateArea({required double length, required double width, String shape = 'rectangle'}) {
  double area;

  if (shape == 'circle') {
    area = length * length * 3.14;
  } else {
    area = length * width;
  }

  return area;
}

class User {
  String name;
  int? age;
  String? email;

  User({required this.name, this.age, this.email});

  void printUserDetails() {
    print('Name: $name');
    print('Age: ${age ?? 'N/A'}');
    print('Email: ${email ?? 'N/A'}');
  }
}