import 'dart:convert';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'comment.dart';
import 'user.dart';
import 'post.dart';
import 'main.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/undefined': (context) => UndefinedPage.fromRouteArguments(ModalRoute.of(context)!.settings.arguments),
      '/user': (context) => UserPage(),
      '/post': (context) => PostPage(),
      '/comment': (context) => CommentPage(),
    },
  ));
}

class HomePage extends StatelessWidget {
  String num = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text('Go to User Page'),
            onPressed: () {
              Navigator.pushNamed(context, '/user');
            },
          ),
          ElevatedButton(
            child: const Text('Go to Post Page'),
            onPressed: () {
              Navigator.pushNamed(context, '/post');
            },
          ),
          ElevatedButton(
            child: const Text('Go to Comment Page'),
            onPressed: () {
              Navigator.pushNamed(context, '/comment');
            },
          ),
          // Create text input field
          TextField(
                        onChanged: (value) {
                          num = value;}),
          ElevatedButton(
            child: const Text('Go to Cats Page'),
            onPressed: () {
              navigateToUndefinedPage(context, int.parse(num));
            },
          ),
        ],
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  final int statusCode;

  UndefinedPage({Key? key, required this.statusCode}) : super(key: key);

  static UndefinedPage fromRouteArguments(Object? arguments) {
    assert(arguments is int);
    return UndefinedPage(statusCode: arguments as int);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Undefined Page'),
      ),
      body: Image.network('https://http.cat/$statusCode'),
    );
  }
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].email),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Icon(Icons.hourglass_empty);
        },
      ),
    );
  }
}

void navigateToUndefinedPage(BuildContext context, int statusCode) {
  Navigator.pushNamed(context, '/undefined', arguments: statusCode);
}

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Page'),
      ),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].body),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Icon(Icons.hourglass_empty);
        },
      ),
    );
  }
}

class CommentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment Page'),
      ),
      body: FutureBuilder<List<Comment>>(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].body),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Icon(Icons.hourglass_empty);
        },
      ),
    );
  }
}