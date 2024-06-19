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
      title: 'Flutter Demo',
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
      home: const HomePage(),
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final post = (await fetchPosts()).first;
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                      title: const Text(
                        'The First Post',
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            'User Id: ${post.userId}\n'
                            'Title: ${post.title}\n'
                            'Body: ${post.body}\n',
                            textAlign: TextAlign.left,
                          ),
                        )
                      ]),
                );
              },
              child: const Text('First'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                final comment = (await fetchComments()).first;
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                      title: const Text(
                        'The First Comment',
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            'Name: ${comment.name}\n'
                            'Email: ${comment.email}\n'
                            'Body: ${comment.body}\n',
                            textAlign: TextAlign.left,
                          ),
                        )
                      ]),
                );
              },
              child: const Text('Second'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                final user = (await fetchUsers()).first;
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                      title: const Text(
                        'The First User',
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            'Name: ${user.name}\n'
                            'Username: ${user.username}\n'
                            'Company: ${user.company['name']}\n',
                            textAlign: TextAlign.left,
                          ),
                        )
                      ]),
                );
              },
              child: const Text('Third'),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.4,
                  right: MediaQuery.of(context).size.width * 0.4,
                  top: 10.0,
                  bottom: 10.0),
              child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Cat-Status-Code',
                    border: OutlineInputBorder(),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                final statusCode = int.tryParse(_controller.text);
                if (statusCode != null) {
                  Navigator.of(context)
                      .pushNamed('/generated', arguments: statusCode);
                }
              },
              child: const Text('Show'),
            ),
          ],
        ),
      ),
    );
  }
}