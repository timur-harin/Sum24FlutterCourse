import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'comment.dart';
import 'post.dart';
import 'user.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  runApp(MyApp());
}

final Map<String, String> routes = {
  '/': '/one',
  '/second': '/second',
  '/third': '/third',
  '/generated': '/generated',
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (routes.containsKey(settings.name)) {
          return MaterialPageRoute(
            builder: (context) => HomePage(),
          );
        } else if (settings.name == '/generated') {
          final int statusCode = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => GeneratedPage(statusCode: statusCode),
          );
        } else {
          final name = settings.name ?? '';
          if (name.contains('/generated')) {
            return MaterialPageRoute(
              builder: (context) =>
                  GeneratedPage(statusCode: int.parse(name.split('/').last)),
            );
          }
          return MaterialPageRoute(
            builder: (context) => UndefinedRoutePage(settings.name),
          );
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => UndefinedRoutePage(settings.name),
        );
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
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
              child: Text('Show Comments'),
            ),
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
              child: Text('Show Posts'),
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
              child: Text('Show Users'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter status code',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final statusCode = int.tryParse(_controller.text);
                if (statusCode != null) {
                  // go to MaterialpageRoute
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GeneratedPage(statusCode: statusCode)));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Invalid Input'),
                      content: Text('Please enter a valid number.'),
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
              child: Text('Show Cat Status'),
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
      appBar: AppBar(
        title: Text('Generated Page'),
      ),
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
        title: Text('Undefined Route'),
      ),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}
