import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'post.dart';
import 'comment.dart';
import 'user.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        if (name.contains('/generated')) {
          String statusCode = name.replaceFirst('/generated/', '');
          return MaterialPageRoute(
              builder: (context) =>
                  CatStatusCodePage(statusCode: statusCode));
        } else if (name == '/posts') {
          final List<Post> posts = settings.arguments as List<Post>;
          return MaterialPageRoute(builder: (context) => PostsPage(posts: posts));
        } else if (name == '/comments') {
          final List<Comment> comments = settings.arguments as List<Comment>;
          return MaterialPageRoute(builder: (context) => CommentsPage(comments: comments));
        } else if (name == '/users') {
          final List<User> users = settings.arguments as List<User>;
          return MaterialPageRoute(builder: (context) => UsersPage(users: users));
        } else {
          int statusCode = int.tryParse(name.replaceFirst('/', '')) ?? 404;
          return MaterialPageRoute(builder: (context) => ErrorPage(statusCode: statusCode));
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const UndefinedPage());
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            ElevatedButton(
              onPressed: () async {
                try {
                  List<Post> posts = await fetchPosts();
                  Navigator.pushNamed(context, '/posts', arguments: posts);
                } catch (e) {
                  Navigator.pushNamed(context, '/500');
                }
              },
              child: Text('Fetch Posts'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  List<Comment> comments = await fetchComments();
                  Navigator.pushNamed(context, '/comments', arguments: comments);
                } catch (e) {
                  Navigator.pushNamed(context, '/500');
                }
              },
              child: Text('Fetch Comments'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  List<User> users = await fetchUsers();
                  Navigator.pushNamed(context, '/users', arguments: users);
                } catch (e) {
                  Navigator.pushNamed(context, '/500');
                }
              },
              child: Text('Fetch Users'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter status code',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                    '/generated/${textController.text}',
                    arguments: textController.text);
              },
              child: Text('Show Cat for Status Code'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostsPage extends StatelessWidget {
  final List<Post> posts;

  PostsPage({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
          );
        },
      ),
    );
  }
}

class CommentsPage extends StatelessWidget {
  final List<Comment> comments;

  CommentsPage({required this.comments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return ListTile(
            title: Text(comment.name),
            subtitle: Text(comment.body),
          );
        },
      ),
    );
  }
}

class UsersPage extends StatelessWidget {
  final List<User> users;

  UsersPage({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final int statusCode;

  ErrorPage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Code $statusCode'),
      ),
      body: Center(
        child: Image.network('https://http.cat/$statusCode'),
      ),
    );
  }
}

class CatStatusCodePage extends StatelessWidget {
  final String statusCode;

  CatStatusCodePage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Code $statusCode'),
      ),
      body: Center(
        child: isValidStatusCode(statusCode)
            ? Image.network('https://http.cat/$statusCode')
            : statusCode == '404'
            ? Text('No cat found for status code 404')
            : Text('Invalid status code: $statusCode'),
      ),
    );
  }

  bool isValidStatusCode(String statusCode) {
    // Here you can add your own logic to validate if a cat image exists for the given status code
    // For example, check against a predefined list of valid status codes
    List<String> validStatusCodes = ['100', '200', '300', '400', '500'];
    return validStatusCodes.contains(statusCode);
  }
}

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Not Found'),
      ),
      body: Center(
        child: Text('404 Page Not Found'),
      ),
    );
  }
}
