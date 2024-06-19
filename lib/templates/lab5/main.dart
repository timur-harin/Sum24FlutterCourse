// Use these dependencies for your classes
import 'dart:convert';
import 'package:education/livecoding/async/main.dart';
import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MainPage(),
      },
      title: "lab 5",
      initialRoute: "/",
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const UnknownPage());
      },
      onGenerateRoute: (settings) {
        if (settings.name!.contains("get_cats")) {
          String statusCode = settings.name!.split("get_cats")[1];

          return MaterialPageRoute(builder: (context) => GeneratedPage(statusCode: statusCode));
        } else if (settings.name == "/") {
          return MaterialPageRoute(builder: (context) => const MainPage());
        } else {
          return MaterialPageRoute(builder: (context) => const UnknownPage());
        }
      },


    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late String _response = "not requested";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  List<Post> posts = await fetchPosts();
                  setState(() {
                    _response =  posts.first.body;
                  });
                  },
                child: const Text("Task 1")
            ),
            ElevatedButton(
                onPressed: () async {
                  List<Comment> posts = await fetchComments();
                  setState(() {
                    _response =  posts.first.body;
                  });
                },
                child: const Text("Task 2")
            ),
            ElevatedButton(
                onPressed: () async {
                  List<User> users = await fetchUsers();
                  setState(() {
                    _response =  "username is ${users.first.name}";
                    // _response =  "Username: asd";

                  });
                },
                child: const Text("Task 3")
            ),
            const Text("To get cats follow ./get_cats/[STATUS_CODE]"),
            Text("Response text: $_response")
          ],
        ),
      ),
    );
  }
}



class GeneratedPage extends StatefulWidget {
  final String statusCode;

  const GeneratedPage({super.key, required this.statusCode});

  @override
  State<GeneratedPage> createState() => _GeneratedPageState();
}

class _GeneratedPageState extends State<GeneratedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network("https://http.cat/images${widget.statusCode}.jpg"),
      ),
    );
  }
}


class UnknownPage extends StatefulWidget {
  const UnknownPage({super.key});

  @override
  State<UnknownPage> createState() => _UnknownPageState();
}

class _UnknownPageState extends State<UnknownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Image.network("https://http.cat/images/404.jpg"),
      ),
    );
  }
}




// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

