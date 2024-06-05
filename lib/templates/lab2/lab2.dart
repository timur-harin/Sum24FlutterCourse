class Book with JsonSerializable {
  final String title;
  final String author;
  final int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);
  void bookDetails() {
    print("$title, $author, $numberOfPages");
  }
}

class FictionBook {
  // your code here
}

mixin JsonSerializable {
  String? title;
  String? author;
  int? numberOfPages;
  Map? toJson() {
    Map? tempMap = {
      "title": title,
      "author": author,
      "numberOfPages": numberOfPages
    };
    return tempMap;
  }
}

double calculateArea() {
  // your code here
}

class User {
  // your code here
}
