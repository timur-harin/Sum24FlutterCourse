import 'package:flutter/material.dart';
import 'comment.dart';
import 'post.dart';
import 'user.dart';

void main() {
  runApp(const MyApp());
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
            builder: (context) => GeneratedPage(statusCode: statusCode),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => UndefinedRoutePage(settings.name),
          );
        }
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                      );
                    }).toList(),
                  ),
                );
              },
              child: const Text(
                'Comments',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final posts = await fetchPosts();
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text(
                      'Posts',
                    ),
                    children: posts.map((post) {
                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                      );
                    }).toList(),
                  ),
                );
              },
              child: const Text(
                'Posts',
              ),
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
                      );
                    }).toList(),
                  ),
                );
              },
              child: const Text(
                'Users',
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Status code',
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final statusCode = int.tryParse(_controller.text);
                if (statusCode != null) {
                  Navigator.of(context)
                      .pushNamed('/generated', arguments: statusCode);
                }
              },
              child: const Text(
                'Cats',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GeneratedPage extends StatelessWidget {
  final int statusCode;

  const GeneratedPage({super.key, required this.statusCode});

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

  const UndefinedRoutePage(this.routeName, {super.key});

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