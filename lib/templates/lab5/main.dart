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
      title: 'Cat Status',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        title: const Text('Выбери своего бойца',
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
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
                    title: Text('Комменты'),
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
              child: const Text('Показать комменты',
              style: TextStyle(
                color: Color.fromARGB(255, 216, 30, 233)
              ),),
            ),
            ElevatedButton(
              onPressed: () async {
                final posts = await fetchPosts();
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text('Посты',
                      style: TextStyle(
                          color: Color.fromARGB(255, 12, 175, 170)
                      ),),
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
              child: Text('Показать посты', style: TextStyle(
                  color: Color.fromARGB(255, 184, 221, 38)
              ),),
            ),
            ElevatedButton(
              onPressed: () async {
                final users = await fetchUsers();
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text('Пользователи'),
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
              child: Text('Пользователи',
                style: TextStyle(
                    color: Color.fromARGB(255, 45, 8, 195)
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Напиши номер кота',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final statusCode = int.tryParse(_controller.text);
                if (statusCode != null) {
                  Navigator.of(context).pushNamed('/generated', arguments: statusCode);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Неверный номер'),
                      content: Text('Напиши правильный номер'),
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
              child: Text('Найти',
                style: TextStyle(
                    color: Color.fromARGB(255, 19, 137, 6)
                ),),
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
        title: Text('OSHIBKA'),
      ),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}