// Use these dependencies for your classes
import 'dart:convert';
import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'cat_sh.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    Map<String, String> routes = {
    '/': '/one',
    '/cats': '/cats',
  };

  String displayTextPost = '1';
  String displayTextComment = '2';
  String displayTextUser = '3';

  void updateTextPost() async {
    var somePost = await getRandomPost();
    setState(() {
      displayTextPost =
          'Person with ID ${somePost.userId}: \n"${somePost.title}"\n';
    });
  }

  void updateTextComment() async {
    var somePost = await getRandomComment();
    setState(() {
      displayTextComment =
          'Person with Email ${somePost.email}: has name "${somePost.name}"\n';
    });
  }

  void updateTextUser() async {
    var somePost = await getRandomUser();
    setState(() {
      displayTextUser =
          'Person with ID ${somePost.id}: has website ${somePost.website}"\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/one": (context) => MyApp(),
      },
      onGenerateRoute: (settings) {
        print(settings.name);
        return MaterialPageRoute(
          builder: (context) => GeneratedPage(status: settings.name!)
        );
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('LAB 5'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  updateTextPost();
                },
                child: Text('Get a random Post'),
              ),
              SizedBox(width: 20), // Add space between button and text
              Text(displayTextPost),
              ElevatedButton(
                onPressed: () {
                  updateTextComment();
                },
                child: Text('Get a random Comment'),
              ),
              SizedBox(width: 20), // Add space between button and text
              Text(displayTextComment),
              ElevatedButton(
                onPressed: () {
                  updateTextUser();
                },
                child: Text('Get a random User'),
              ),
              SizedBox(width: 20), // Add space between button and text
              Text(displayTextUser),
            ],
          ),
        ),
      ),
    );
  }
}

