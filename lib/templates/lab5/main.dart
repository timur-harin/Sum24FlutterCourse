import 'dart:convert';
import 'package:education/templates/lab5/cat_page.dart';
import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/undefined_page.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}
TextEditingController textController = TextEditingController();


void main() {
    WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final Map<String, String> routes = {
    '/': '/',
    '/generated': '/generated',
    '/generated/${textController.text}':
        '/generated//generated/${textController.text}',
  };
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/': (context) => MainScreen(),
        },
        onGenerateRoute: (settings) {
          if (routes.containsKey(settings.name)) {
            return MaterialPageRoute(
                builder: (context) => CatStatusCodePage(statusCode: settings.name!));
          }
          final name = settings.name ?? '';
          print(name);
          if (name.contains('/generated')) {
            print(true);
            return MaterialPageRoute(
                builder: (context) => CatStatusCodePage(statusCode: settings.name!));
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => UndefinedPage());
        });
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  final posts = await fetchPosts();
                  String f = '';
                  for (Post post in posts) {
                    f += post.title +
                        " " +
                        post.body +
                        " " +
                        post.id.toString() +
                        "\n";
                  }
      
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Posts"),
                            content: Text(f),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"))
                            ],
                          ));
                },
                child: const Text("Posts")),
            ElevatedButton(
                onPressed: () async {
                  final comments = await fetchComments();
                  String f = '';
                  for (Comment comment in comments) {
                    f += comment.name +
                        " " +
                        comment.body +
                        " " +
                        comment.email +
                        "\n";
                  }
      
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Comments"),
                            content: Text(f),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"))
                            ],
                          ));
                },
                child: const Text("Comments")),
            ElevatedButton(
                onPressed: () async {
                  final users = await fetchUsers();
                  String f = '';
                  for (User user in users) {
                    f += user.name! +
                        " " +
                        user.username! +
                        " " +
                        user.email! +
                        "\n";
                  }
      
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Users"),
                            content: Text(f),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"))
                            ],
                          ));
                },
                child: const Text("Users")),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter text',
                    ), 
                    controller: textController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print(textController.text);
                    Navigator.of(context).pushNamed('/generated/${textController.text}', arguments: textController.text);
                  },
                  child: const Text("Open cats"),
                ),
          ],
        ),
      ),
    );
  }
}