import 'package:flutter/material.dart';

import 'CatPage.dart';
import 'CommentPage.dart';
import 'PostPage.dart';
import 'UserPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4',
      home: MyHomePage(),
      routes: {
        '/comments': (context) => CommentPage(),
        '/posts': (context) => PostPage(),
        '/users': (context) => UserPage(),
        '/cats': (context) => CatPage(statusCode: 200),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab 4'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Comments'),
              onPressed: () {
                Navigator.pushNamed(context, '/comments');
              },
            ),
            ElevatedButton(
              child: Text('Posts'),
              onPressed: () {
                Navigator.pushNamed(context, '/posts');
              },
            ),
            ElevatedButton(
              child: Text('Users'),
              onPressed: () {
                Navigator.pushNamed(context, '/users');
              },
            ),
             ElevatedButton(
              child: Text('Cats'),
              onPressed: () {
                Navigator.pushNamed(context, '/cats');
              },
            ),
            
          ],
        ),
      ),
    );
  }
}