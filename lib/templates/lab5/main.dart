import 'dart:convert';
import 'package:education/livecoding/json/run.dart';
import 'package:education/livecoding/navigation/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'post.dart';
import 'comment.dart';
import 'user.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

void main() {
  configureApp();
  runApp(const MainPage());
}

final Map<String, String> routes = {
  '/': '/one',
  '/second': '/second',
  '/third': '/third',
  '/generated': '/generated',
};

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/generated') {
          print(settings.arguments);
          return MaterialPageRoute(
              builder: (context) =>
                  GeneratedPage(code: settings.arguments as int));
        } else {
          return MaterialPageRoute(builder: (context) => UndefinedPage());
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
                onPressed: () async {
                  final results = await fetchPosts();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Posts'),
                          content: Text(
                              json.encode(results.first.toJson(results.first))),
                        );
                      });
                },
                child: const Text('Task #1 (posts)')),
            OutlinedButton(
                onPressed: () async {
                  final results = await fetchComments();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Comments'),
                          content: Text(json.encode(results.first.toJson())),
                        );
                      });
                },
                child: const Text('Task #2 (comments)')),
            OutlinedButton(
                onPressed: () async {
                  final results = await fetchUsers();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Users'),
                          content: Text(json.encode(results.first.toJson())),
                        );
                      });
                },
                child: const Text('Task #3 (users)')),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Status code:'),
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  final code = int.tryParse(_controller.text);
                  if (code != null) {
                    print('!!!!!!!!!');
                    Navigator.of(context)
                        .pushNamed('/generated', arguments: code);
                  } else {
                    print('Invalid input');
                  }
                },
                child: const Text('OK')),
          ],
        ),
      ),
    );
  }
}

class GeneratedPage extends StatelessWidget {
  GeneratedPage({super.key, required this.code}) {
    print("${code}");
  }
  final int code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.network('https://http.cat/$code'),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Undefined'),
      ),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

