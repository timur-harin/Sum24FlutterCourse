// Use these dependencies for your classes
import 'dart:convert';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'comment.dart';
import 'post.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/generated') {
          final int statusCode = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => GeneratedPage(statusCode: statusCode),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => UndefinedRoutePage(settings.name),
          );
        }
      },
      home: HomePage(),
    );
  }
}

// TODO add needed classes for Flutter APP
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// TODO add generated route flutter app with undifined page with cat status code using api
class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

// TODO add putting argument in route navigation as parameter for generated page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a cat app',
          style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
            onPressed: () async {
      final posts = await fetchPosts();
      String f = '';
      for (Post post in posts) {
      f += 'title: ${post.title}\nbody: ${post.body}\n';
      }
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
      content: Text(f),
      ),
      );
      },
        child: const Text('Parse posts'),
      ),
      ElevatedButton(
        onPressed: () async {
          final comments = await fetchComments();
          String f = '';
          for (Comment comment in comments) {
            f += 'postId: ${comment.postId}\nid: ${comment.id}\nname: ${comment.name}\nemail: ${comment.email}\nbody: ${comment.body}\n\n';
          }
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  content: Text(f),
                ),
          );
        },
        child: const Text('Parse comments'),
      ),
      ElevatedButton(
        onPressed: () async {
          final users = await fetchUsers();
          String f = '';
          for (User user in users) {
            f += 'id: ${user.id}\nname: ${user.name}\nemail: ${user.email}\n\n';
          }
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(f),
            ),
          );
        },
        child: const Text('Parse users'),
      ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter status code',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                    '/generated/${_controller.text}',
                    arguments: _controller.text);
              },
              child: const Text("Открыть котов"),
            ),
          ],
        ),
      ),
    );
  }
}

class UndefinedRoutePage extends StatelessWidget {
  final String? routeName;

  UndefinedRoutePage(this.routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undefined Route'),
      ),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Undefined Page'),
      ),
      body: const Center(
        child: Text('Undefined Page'),
      ),
    );
  }
}

// TODO use api with cat status codes
// https://http.cat/[status_code]
class GeneratedPage extends StatelessWidget {
  final int statusCode;

  GeneratedPage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network('https://http.cat/$statusCode'),
      ),
    );
  }
}

