import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:flutter/material.dart';
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
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/': (context) => const MainScreen(),
        },
        onGenerateRoute: (settings) {
          if (routes.containsKey(settings.name)) {
            return MaterialPageRoute(builder: (context) => MainScreen());
          }
          final name = settings.name ?? '';

          if (name.contains('/generated')) {
            return MaterialPageRoute(
                builder: (context) =>
                    CatStatusCodePage(statusCode: settings.name!));
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => const UndefinedPage());
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
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text',
              ),
              controller: textController,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                    '/generated/${textController.text}',
                    arguments: textController.text);
              },
              child: const Text("Открыть котов"),
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: Text(post.title),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
              child: const Text("Posts"),
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
                        title: Text(user.name ?? 'No Name'),
                        subtitle: Text(user.email ?? 'No Email'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: Text(user.name ?? 'No Name'),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(user.email ?? 'No Email'),
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
              child: const Text(
                'Show Users',
              ),
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
                                  padding: const EdgeInsets.all(8.0),
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
              child: const Text(
                'Show Comments',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Undefined page'),
      ),
    );
  }
}

class CatStatusCodePage extends StatelessWidget {
  final String statusCode;

  const CatStatusCodePage({super.key, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    var code = int.parse(statusCode.split('/').last);
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://http.cat/$code',
        ),
      ),
    );
  }
}
