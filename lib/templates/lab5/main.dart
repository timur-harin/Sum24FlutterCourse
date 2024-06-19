import 'package:flutter/material.dart';

import 'post.dart';
import 'comment.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/post': (context) => const PostPage(),
        '/comment': (context) => const CommentPage(),
        '/user': (context) => const UserPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => const UndefinedRoutePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
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
            ElevatedButton(
              onPressed: () async {
                var posts = await fetchPosts();
                var arg = posts.map((post) => post.toJson()).toList();
                Navigator.pushNamed(
                  context, 
                  '/post',
                  arguments: arg,
                );
              },
              child: const Text('Posts'),
            ),
            ElevatedButton(
              onPressed: () async {
                var comments = await fetchComments();
                var arg = comments.map((post) => post.toJson()).toList();
                Navigator.pushNamed(
                  context, 
                  '/comment',
                  arguments: arg,
                );
              },
              child: const Text('Comments'),
            ),
            ElevatedButton(
              onPressed: () async {
                var users = await fetchUsers();
                var arg = users.map((post) => post.toJson()).toList();
                Navigator.pushNamed(
                  context,
                  '/user',
                  arguments: arg,
                );
              },
              child: const Text('Users'),
            ),
          ],
        )
      )
    );
  }
}

class PostPage extends StatelessWidget {
  const PostPage({super.key});
  @override
  Widget build(BuildContext context) {
    final posts = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: posts == null
              ? const Text('Failed to load posts')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: posts.map((post) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Title: ${post['title']}\nBody: ${post['body']}\n',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}

class CommentPage extends StatelessWidget {
  const CommentPage({super.key});
  @override
  Widget build(BuildContext context) {
    final comments = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: comments == null
              ? const Text('Failed to load comments')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: comments.map((comment) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Name: ${comment['name']}\nEmail: ${comment['email']}\nBody: ${comment['body']}\n',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    final users = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: users == null
                ? const Text('Failed to load users')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: users.map((user) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Name: ${user['name']}\nUsername: ${user['username']}\nEmail: ${user['email']}\nPhone: ${user['phone']}\nWebsite: ${user['website']}\n',
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ),
    );
  }
}

class UndefinedRoutePage extends StatelessWidget {
  final String? routeName;

  const UndefinedRoutePage({this.routeName, super.key});

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