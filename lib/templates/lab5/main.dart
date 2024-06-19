import 'package:flutter/material.dart';
import 'comment.dart';
import 'post.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'lab 5',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
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
        title: const Text(
          'Find a cat app',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildGradientButton(
              onPressed: () async {
                try {
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
                } catch (e) {
                  print('Error fetching comments: $e');
                }
              },
              text: 'Show Comments',
            ),
            _buildGradientButton(
              onPressed: () async {
                try {
                  final posts = await fetchPosts();
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: Text(
                        'Posts',
                        style: TextStyle(color: Colors.amber),
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
                } catch (e) {
                  print('Error fetching posts: $e');
                }
              },
              text: 'Show Posts',
            ),
            _buildGradientButton(
              onPressed: () async {
                try {
                  final users = await fetchUsers();
                  print('Fetched ${users.length} users');
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
                } catch (e) {
                  print('Error fetching users: $e');
                }
              },
              text: 'Show Users',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter status code',
                ),
              ),
            ),
            _buildGradientButton(
              onPressed: () {
                final statusCode = int.tryParse(_controller.text);
                if (statusCode != null) {
                  Navigator.of(context).pushNamed('/generated', arguments: statusCode);
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
              text: 'Show Cat Status',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton({required VoidCallback onPressed, required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFFBEA), Color(0xFFB7906B)],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class GeneratedPage extends StatelessWidget {
  final int statusCode;

  const GeneratedPage({Key? key, required this.statusCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status $statusCode'),
      ),
      body: Center(
        child: Image.network('https://http.cat/$statusCode'),
      ),
    );
  }
}

class UndefinedRoutePage extends StatelessWidget {
  final String? routeName;

  const UndefinedRoutePage(this.routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Not Found'),
      ),
      body: Center(
        child: Text('No route defined for $routeName'),
      ),
    );
  }
}
