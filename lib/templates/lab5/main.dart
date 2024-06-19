import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

TextEditingController textController = TextEditingController();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MyHomePage(),
      },
      title: 'Lab 5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name != null && settings.name!.startsWith('/generated/')) {
          final statusCode = settings.name!.replaceFirst('/generated/', '');
          return MaterialPageRoute(
            builder: (context) => AnotherPage(statusCode: statusCode),
          );
        }
        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const UndefinedPage());
      },
    );
  }
}

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: const Center(
        child: Text('Sorry, the page you are looking for does not exist.'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Status Code',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final statusCode = textController.text;
                Navigator.of(context).pushNamed('/generated/$statusCode');
              },
              child: const Text('Go to Another Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final posts = await fetchPosts();
                String f = '';
                for (Post post in posts) {
                  f += "${post.title} ${post.body} ${post.id}\n";
                }
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Task 1"),
                    content: Text(f),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Posts'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final comments = await fetchComments();
                String f = '';
                for (Comment comment in comments) {
                  f += "${comment.name} ${comment.body} ${comment.email}\n";
                }
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Task 2"),
                    content: Text(f),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Comments'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final users = await fetchUsers();
                String f = '';
                for (User user in users) {
                    f += "${user.name} ${user.username!} ${user.email!}\n";
                  }
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Task 3"),
                    content: Text(f),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Users"),
            ),
          ],
        ),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  final String statusCode;
  const AnotherPage({super.key, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    final imageURL = 'https://http.cat/$statusCode';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'),
      ),
      body: Center(
        child: Image.network(imageURL),
      ),
    );
  }
}
