import 'package:education/templates/lab5/cat.dart';
import 'package:education/templates/lab5/commentPage.dart';
import 'package:education/templates/lab5/postPage.dart';
import 'package:education/templates/lab5/userPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'comment.dart';
import 'post.dart';
import 'user.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    
    )
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Comments'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsPage(fetchComments)));
              },
            ),
            ElevatedButton(
              child: Text('Posts'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PostsPage(fetchPosts)));
              },
            ),
            ElevatedButton(
              child: Text('Users'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UsersPage(fetchUsers)));
              },
            ),
            ElevatedButton(
              child: Text('Cat'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CatPage(statusCode: 300)));
              },
            ),
          ],
        ),
      ),
    );
  }
}