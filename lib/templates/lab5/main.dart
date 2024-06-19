import 'package:flutter/material.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/comment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/cat': (context) => CatStatusCodePage(statusCode: ModalRoute.of(context)!.settings.arguments as String),
        '/users': (context) => UsersPage(),
        '/posts': (context) => PostsPage(),
        '/comments': (context) => CommentsPage(),
      },
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
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter status code',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              child: Text('Go to Cat Page'),
              onPressed: () {
                String statusCode = _controller.text.isEmpty ? '404' : _controller.text;
                Navigator.pushNamed(context, '/cat', arguments: statusCode);
              },
            ),
            ElevatedButton(
              child: Text('Go to Users Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/users');
              },
            ),
            ElevatedButton(
              child: Text('Go to Comments Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/comments');
              },
            ),
            ElevatedButton(
              child: Text('Go to Posts Page'),
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

  const CatStatusCodePage({Key? key, required this.statusCode})
      : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: FutureBuilder(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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