import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      title: 'HTTP Cat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/undefined') {
          return MaterialPageRoute(builder: (context) => UndefinedRoutePage(settings.name));
        }
        var statusCode = int.tryParse(settings.name?.substring(1) ?? '');
        if (statusCode != null) {
          return MaterialPageRoute(builder: (context) => GeneratedPage(statusCode: statusCode));
        }
        
        return MaterialPageRoute(builder: (context) => UndefinedRoutePage(settings.name));
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Cat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter a status code',
              ),
            ),
            ElevatedButton(
              child: Text('Show Cat Status'),
              onPressed: () {
                Navigator.pushNamed(context, '/${_controller.text}');
              },
            ),

            ElevatedButton(
              onPressed: () async {
                final posts = await fetchPosts();
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text('Posts'),
                    children: posts.map((post) {
                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: Text(post.title),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
              child: Text('Show Posts'),
            ),
            ElevatedButton(
              onPressed: () async {
                final comments = await fetchComments();
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text('Comments'),
                    children: comments.map((comment) {
                      return ListTile(
                        title: Text(comment.name),
                        subtitle: Text(comment.body),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: Text(comment.name),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
              child: const Text('Show Comments'),
            ),
            ElevatedButton(
              onPressed: () async {
                final users = await fetchUsers();
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text('Users'),
                    children: users.map((user) {
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: Text(user.name),

                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
              child: const Text('Show Users'),
            ),
          ],
        ),
      ),
    );
  }
}

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

class UndefinedRoutePage extends StatelessWidget {
  final String? routeName;

  UndefinedRoutePage(this.routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Undefined Route'),
      ),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}