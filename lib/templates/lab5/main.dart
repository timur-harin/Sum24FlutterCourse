import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  final posts = await fetchPosts();
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: Text('Posts'),
                      children: posts.map((post) {
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: Text(
                                  post.title,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(182, 10, 10, 1)),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(post.body),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
                child: Text('View Posts'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final comments = await fetchComments();
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: Text('Comments'),
                      children: comments.map((comment) {
                        return ListTile(
                          title: Text(comment.name),
                          subtitle: Text(comment.body),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: Text(comment.name),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(comment.body),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
                child: Text('Comments'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final users = await fetchUsers();
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: Text('Users'),
                      children: users.map((user) {
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: Text(user.name),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(user.email),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
                child: Text('Users'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _inputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter status code',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final statusCode = int.tryParse(_inputController.text);
                  if (statusCode != null) {
                    Navigator.of(context)
                        .pushNamed('/status', arguments: statusCode);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Invalid Input'),
                        content: Text('Please enter a valid number'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Show Cat Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
          child: Image.network('https://http.cat/404'),
        ),
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  final int statusCode;

  StatusPage({required this.statusCode});

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
