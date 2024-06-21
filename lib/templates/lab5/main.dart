import 'package:flutter/material.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/comment.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/cat': (context) => CatStatusCodePage(statusCode: ModalRoute.of(context)!.settings.arguments as String),
        '/users': (context) => const UsersPage(),
        '/posts': (context) => const PostsPage(),
        '/comments': (context) => const CommentsPage(),
      },
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
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter status code',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              child: const Text('Go to Cat Page'),
              onPressed: () {
                String statusCode = _controller.text.isEmpty ? '404' : _controller.text;
                Navigator.pushNamed(context, '/cat', arguments: statusCode);
              },
            ),
            ElevatedButton(
              child: const Text('Go to Users Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/users');
              },
            ),
            ElevatedButton(
              child: const Text('Go to Comments Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/comments');
              },
            ),
            ElevatedButton(
              child: const Text('Go to Posts Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/posts');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CatStatusCodePage extends StatelessWidget {
  final String statusCode;

  const CatStatusCodePage({super.key, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://http.cat/${statusCode.split('/').last}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Code: ${statusCode.split('/').last}'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: (snapshot.data as List<User>).length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text((snapshot.data as List<User>)[index].name!),
                  subtitle: Text((snapshot.data as List<User>)[index].email!),
                );
              },
            );
          }
        },
      ),
    );
  }
}
class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: FutureBuilder(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: (snapshot.data as List<Comment>).length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text((snapshot.data as List<Comment>)[index].name),
                  subtitle: Text((snapshot.data as List<Comment>)[index].body),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: (snapshot.data as List<Post>).length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text((snapshot.data as List<Post>)[index].title),
                  subtitle: Text((snapshot.data as List<Post>)[index].body),
                );
              },
            );
          }
        },
      ),
    );
  }
}