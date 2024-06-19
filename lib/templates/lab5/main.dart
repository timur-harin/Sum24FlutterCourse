import 'package:flutter/material.dart';
import 'comment.dart';
import 'post.dart';
import 'user.dart';

//Sorry for copying, I am just trying to make at least anything myself, but unsuccessful
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 5',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
        backgroundColor: Colors.black,
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
              child: const Text(
                'Show comments',
                style: TextStyle(color: Color.fromARGB(255, 0, 71, 71)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final posts = await fetchPosts();
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text(
                      'Posts',
                      style: TextStyle(color: Color.fromARGB(255, 0, 71, 71)),
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
              child: Text(
                'Show Posts',
                style: TextStyle(color: Color.fromARGB(255, 0, 71, 71)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final users = await fetchUsers();
                showDialog(
                  //know what this does, but not how that map works
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
              child: Text(
                'Show Users',
                style: TextStyle(color: Color.fromARGB(255, 0, 71, 71)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                  4.0), // Don't know this, but know what padding is
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter status code',
                ),
              ),
            ),
            ElevatedButton(
              // I know what this does
              onPressed: () {
                final statusCode = int.tryParse(
                    _controller.text); // I don't know what this does
                if (statusCode != null) {
                  Navigator.of(context) // I don't know what this does
                      .pushNamed('/generated', arguments: statusCode);
                } else {
                  showDialog(
                    // I know what this does
                    context: context,
                    builder: (context) => AlertDialog(
                      // I know what this does
                      title: Text('Invalid Input'),
                      content: Text(
                          'Please, enter the 3-digit number [0:511] above the button You have pressed.'),
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
              child: Text(
                'Show Cat Status',
                style: TextStyle(color: Color.fromARGB(255, 0, 71, 71)),
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

  GeneratedPage({required this.statusCode});
// https://http.cat/[status_code]
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

  UndefinedRoutePage(this.routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incorrect Path'),
      ),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}
