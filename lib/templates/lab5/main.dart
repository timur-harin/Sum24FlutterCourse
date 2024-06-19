import 'package:flutter/material.dart';
import 'posts_page.dart';
import 'user_page.dart';
import 'comments_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                backgroundColor: Color.fromARGB(255, 201, 201, 201),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommentsPage()),
              ),
              child: Text('View Comments'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 44),
                backgroundColor: Color.fromARGB(255, 201, 201, 201),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostsPage()),
              ),
              child: Text('View Posts'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 44),
                backgroundColor: Color.fromARGB(255, 201, 201, 201),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UsersPage()),
              ),
              child: Text('View Users'),
            ),
          ],
        ),
      ),
    );
  }
}
