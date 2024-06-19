// Use these dependencies for your classes
import 'package:flutter/material.dart';
import 'comment.dart';
import 'post.dart';
import 'user.dart'; 


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

// TODO add needed classes for Flutter APP
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/generated') {
          return MaterialPageRoute(
            builder: (context) => GeneratedPage(statusCode: settings.arguments as int),
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
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Code',
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
        child: Column(children: [
          Text(
            'Code: $statusCode',
          ),
          Image.network('https://http.cat/$statusCode'),
        ],)
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
        title: const Text('Undefined Cat'),
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

