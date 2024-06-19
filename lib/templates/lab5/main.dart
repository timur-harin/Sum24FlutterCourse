import 'package:education/templates/lab5/post_page.dart';
import 'package:education/templates/lab5/user_page.dart';
import 'package:flutter/material.dart';

import 'cat_page.dart';
import 'comments_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Status Codes',
      initialRoute: '/home',
      onGenerateRoute: (settings) {

        if (settings.name!.contains("cat")) {

          print("34");
          // final args = settings.arguments as Map<String, dynamic>;
          // final statusCode = args['statusCode'];
          // Based on the statusCode, you can load different images
          // Update the image widget based on the statusCode
          var str = settings.name.toString();
          var code = str.substring(str.length - 3);
          bool isValid = RegExp(r'^\d{3}$').hasMatch(code);
          int statusCode = 404;

          if (isValid) {
            statusCode = int.parse(code);
          }
          // print(statusCode.toString());
          return MaterialPageRoute(builder: (context) => CatPage(statusCode: statusCode));
        }
        // Handle other routes here
      },
      routes: {
        '/home': (context) => HomePage(),
        '/cat': (context) => CatPage(statusCode: 200),
        '/comments': (context) => CommentsPage(),
        // '/cat/:statusCode': (context) => CatPage(statusCode: int.parse(ModalRoute.of(context)!.settings.arguments as String)),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Codes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Go to Cat Status Code 200'),
              onPressed: () {
                Navigator.pushNamed(context, '/cat');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Go to Comments'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommentsPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Go to Users'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Go to Posts'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}