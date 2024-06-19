// Use these dependencies for your classes
import 'dart:convert';
import 'package:education/templates/lab4/main.dart';
import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}


class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks. Lab5'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                List<Post> posts = await fetchPosts();
                ref.read(task1Provider.notifier).state = Post.toJson(posts[0]).toString();
              },
              child: const Text('Task 1'),
            ),
            Text(
              ref.watch(task1Provider)
            ),

            ElevatedButton(
              onPressed: () async {
                List<Comment> posts = await fetchComments();
                ref.read(task2Provider.notifier).state = posts[0].toJson().toString();
              },
              child: const Text('Task 2'),
            ),
            Text(
              ref.watch(task2Provider)
            ),

            ElevatedButton(
              onPressed: () async {
                List<User> posts = await fetchUsers();
                print(posts);
                ref.read(task3Provider.notifier).state = posts[0].name.toString();
              },
              child: const Text('Task 3'),
            ),
            Text(
              ref.watch(task3Provider)
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/status',
                  arguments: 200,
                );
              },
              child: const Text('Show Cat'),
            ),
          ],
        ),
      ),
    );
  }
}

final task1Provider = StateProvider<String>((ref) => "");
final task2Provider = StateProvider<String>((ref) => "");
final task3Provider = StateProvider<String>((ref) => "");


// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

class StatusPage extends StatelessWidget {
  final int statusCode;

  StatusPage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status $statusCode'),
      ),
      body: Center(
        child: Image.network(
          'https://http.cat/$statusCode',
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 60.0,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Failed to load image for status $statusCode',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/status':
        if (settings.arguments is int) {
          final int statusCode = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => StatusPage(statusCode: statusCode),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Image.network(
            'https://http.cat/404',
          ),
        ),
      ),
    );
  }
}
