import 'package:education/templates/lab2/lab2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group_button/group_button.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: 
          Column(
            children: [ElevatedButton(onPressed: (){
            void onPressed() {
              Book myBook = Book("Pride and Prejudice", "Jane Austen", 279);
              myBook.bookDetails();
            }
            onPressed();
          }, child: const Icon(Icons.favorite)),

          ElevatedButton(onPressed: (){
            void onPressed() {
              Book myBook = FictionBook("Hobbit", "J.R.R. Tolkien", 295, "Fiction");
              myBook.bookDetails();
            }
            onPressed();
          }, child: const Icon(Icons.star)),
          ElevatedButton(onPressed: (){
            void onPressed() {
              Book myBook = Book("The Dandelion Wine", "Ray Bradbury", 304);
              print(myBook.toJson()) ;            }
            onPressed();
          }, child: const Icon(Icons.sunny)),

          ElevatedButton(onPressed: (){
            void onPressed() {
              print(calculateArea(length: 35, width: 35));          }
            onPressed();
          }, child: const Text("Calculate Area")),
          ElevatedButton(onPressed: (){
            void onPressed() {
                User user = User(name: 'Mary', age: 30, email: 'mary@sad.com');
                user.printUserDetails();           }
            onPressed();
          }, child: const Text("User Details")),
          ],
          )
        ),
      ),
    );
  }
}
