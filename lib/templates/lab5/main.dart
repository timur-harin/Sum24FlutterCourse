import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      onGenerateRoute: (settings) {
        if (settings.name == '/undefined') {
          final args = settings.arguments as Map<String, dynamic>;
          final statusCode = args['statusCode'];
          return MaterialPageRoute(
            builder: (context) => UndefinedPage(statusCode: statusCode),
          );
        }
        return null;
      },
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Comments'),
              Tab(text: 'Users'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PostsTab(),
            CommentsTab(),
            UsersTab(),
          ],
        ),
      ),
    );
  }
}

class PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          Navigator.pushNamed(
            context,
            '/undefined',
            arguments: {'statusCode': 500},
          );
          return Center(child: Text('Error fetching posts'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No posts found'));
        } else {
          return ListView(
            children: snapshot.data!.map((post) => ListTile(title: Text(post.toString()))).toList(),
          );
        }
      },
    );
  }
}

class CommentsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: fetchComments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          Navigator.pushNamed(
            context,
            '/undefined',
            arguments: {'statusCode': 500},
          );
          return Center(child: Text('Error fetching comments'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No comments found'));
        } else {
          return ListView(
            children: snapshot.data!.map((comment) => ListTile(title: Text(comment.toString()))).toList(),
          );
        }
      },
    );
  }
}

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          Navigator.pushNamed(
            context,
            '/undefined',
            arguments: {'statusCode': 500},
          );
          return Center(child: Text('Error fetching users'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No users found'));
        } else {
          return ListView(
            children: snapshot.data!.map((user) => ListTile(title: Text(user.toString()))).toList(),
          );
        }
      },
    );
  }
}

class UndefinedPage extends StatelessWidget {
  final int statusCode;

  UndefinedPage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undefined Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Error: $statusCode',
              style: TextStyle(fontSize: 24),
            ),
            Image.network('https://http.cat/$statusCode'),
          ],
        ),
      ),
    );
  }
}
