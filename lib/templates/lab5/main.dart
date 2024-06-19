import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/posts': (context) => PostsPage(),
        '/comments': (context) => CommentsPage(),
        '/users': (context) => UsersPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => UndefinedPage()),
    );
  }
}

class DataListPage<T> extends StatelessWidget {
  final Future<List<T>> items;
  final String title;
  final Widget Function(T) buildItem;

  DataListPage({
    required this.items,
    required this.title,
    required this.buildItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<List<T>>(
        future: items,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return ListView(
              children: snapshot.data!.map((item) => buildItem(item)).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class PostsPage extends StatelessWidget {
  final Future<List<Post>> posts = fetchPosts();

  @override
  Widget build(BuildContext context) {
    return DataListPage<Post>(
      items: posts,
      title: 'Posts',
      buildItem: (Post post) => ListTile(
        title: Text(post.title),
        subtitle: Text(post.body),
      ),
    );
  }
}

class CommentsPage extends StatelessWidget {
  final Future<List<Comment>> comments = fetchComments();

  @override
  Widget build(BuildContext context) {
    return DataListPage<Comment>(
      items: comments,
      title: 'Comments',
      buildItem: (Comment comment) => ListTile(
        title: Text(comment.name),
        subtitle: Text(comment.body),
        isThreeLine: true,
      ),
    );
  }
}

class UsersPage extends StatelessWidget {
  final Future<List<User>> users = fetchUsers();

  @override
  Widget build(BuildContext context) {
    return DataListPage<User>(
      items: users,
      title: 'Users',
      buildItem: (User user) => ListTile(
        title: Text(user.name),
        subtitle: Text('${user.email}\n${user.phone}'),
        isThreeLine: true,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Show Posts'),
              onPressed: () => Navigator.of(context).pushNamed('/posts'),
            ),
            ElevatedButton(
              child: Text('Show Comments'),
              onPressed: () => Navigator.of(context).pushNamed('/comments'),
            ),
            ElevatedButton(
              child: Text('Show Users'),
              onPressed: () => Navigator.of(context).pushNamed('/users'),
            ),
          ],
        ),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Undefined')),
      body: Center(child: Text('I dont exist lol')),
    );
  }
}
