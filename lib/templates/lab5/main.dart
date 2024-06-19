import 'package:flutter/material.dart';
import 'user.dart';
import 'comment.dart';
import 'post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/status') {
          final args = settings.arguments as List<dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return StatusPage(data: args);
            },
          );
        }
        return MaterialPageRoute(builder: (context) => UndefinedPage());
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                try {
                  final users = await fetchUsers();
                  Navigator.pushNamed(context, '/status', arguments: users);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to fetch users: $e')),
                  );
                }
              },
              child: Text('Fetch Users'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                try {
                  final comments = await fetchComments();
                  String msg = '';
                  for (Comment comment in comments) {
                    msg += 'postId: ${comment.postId}\nid: ${comment.id}\nname: ${comment.name}\nemail: ${comment.email}\nbody: ${comment.body}\n\n';
                  }
                  Navigator.pushNamed(context, '/status', arguments: [msg]);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to fetch comments: $e')),
                  );
                }
              },
              child: Text('Fetch Comments'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                final posts = await fetchPosts();
                String msg = '';
                for (Post post in posts) {
                  msg += 'title: ${post.title}\nbody: ${post.body}\n';
                }
                Navigator.pushNamed(context, '/status', arguments: [msg]);
              },
              child: Text('Fetch Posts'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  final List<dynamic> data;

  StatusPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Details'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            title: Text(item.toString()), // Customize this to display relevant data
          );
        },
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Not Found'),
      ),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}
