// Use these dependencies for your classes
import 'dart:convert';
import 'package:education/templates/lab1/lab1.dart';
import 'package:http/http.dart' as http;
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
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/generated') {
          final int statusCode = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => Generated(statusCode: statusCode),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => UndefinedPage(settings.name),
          );
        }
      },
      home: const HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostPage(),
                  ),
                );
              },
              child: const Text('Posts', style: TextStyle(color: Colors.black, fontSize: 25),),
            ),

            TextButton(
              onPressed: () async{
                final people = await fetchUsers();
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    backgroundColor: Colors.white,
                    title: const Text('Users'),
                    children: people.map((user) {
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      );
                    }).toList(),
                  ),
                );
              },
              child: Text("Users", style: TextStyle(color: Colors.black, fontSize: 25),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Status code',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final statusCode = int.tryParse(_controller.text);
                if (statusCode != null) {
                  Navigator.of(context)
                      .pushNamed('/generated', arguments: statusCode);
                }
              },
              child: const Text('Get an error', style: TextStyle(color: Colors.black, fontSize: 25),),
            ),
          ],
        ),
      ),
    );
  }
}


class Generated extends StatelessWidget {
  final int statusCode;

  const Generated({super.key, required this.statusCode});

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


class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          }
        },
      ),
    );
  }
}


class UndefinedPage extends StatelessWidget {
  final String? name;
  const UndefinedPage(this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Not Found'),
      ),
      body: Center(
         child: Image.network('https://http.cat/404'),
      ),
    );
  }
}

// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

