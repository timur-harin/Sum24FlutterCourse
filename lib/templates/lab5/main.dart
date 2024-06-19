// Use these dependencies for your classes
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'comment.dart';
import 'post.dart';
import 'user.dart';

final catCode = StateProvider<String>((ref) => "404");

final Map<String, String> routes = {
  '/': '/home',
  '/posts': '/posts',
  '/users': '/users',
  '/comments': '/comments',
  '/undefind':'/undefind'
};

void main() {runApp(ProviderScope(child:MyApp()));}

// TODO add needed classes for Flutter APP

class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lab5',
      initialRoute: '/home',
      routes: {
          '/home': (context) => HomeScreen(),
          '/posts': (context) => PostScreen(),
          '/users': (context) => UserScreen(),
          '/comments': (context) => CommentsScreen(),
          '/undefind': (context) => CatScreen(),
        },
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String code="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/posts'
                );
              }, 
              child: Text("Posts")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/users'
                );
              }, 
              child: Text("Users")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/comments'
                );
              }, 
              child: Text("Comments")
            ),
            // Text("Insert status code"),
            TextField(
              decoration: InputDecoration(
                labelText: 'Insert status code',
                hintText: 'Type only integers',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                code = value;
              },
            ),
            ElevatedButton(
              onPressed: () {
                  ref.read(catCode.notifier).state = code;
                  Navigator.of(context).pushNamed(
                    '/undefind'
                  );
                },
              child: Text("See the cat")

            )
          ],
        )
      )
    );
  }
}

class PostScreen extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostScreen> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = fetchPosts();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Posts'),
    ),
    body: FutureBuilder<List<Post>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final post = snapshot.data![index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                onTap: () async {
                  return showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(post.title),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('User ID: ${post.userId}'),
                              Text('ID: ${post.id}'),
                              Text('Body: ${post.body}'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
  );
}
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  onTap: () async {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(user.name),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('ID: ${user.id}'),
                                Text('Username: ${user.username}'),
                                Text('Email: ${user.email}'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  
  }
}

class CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late Future<List<Comment>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: FutureBuilder<List<Comment>>(
        future: _commentsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final comment = snapshot.data![index];
                return ListTile(
                  title: Text(comment.name),
                  subtitle: Text(comment.body),
                  onTap: () async {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(comment.name),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Post ID: ${comment.postId}'),
                                Text('ID: ${comment.id}'),
                                Text('Email: ${comment.email}'),
                                Text('Body: ${comment.body}'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}



class CatScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = ref.watch(catCode);
    print(code);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Code'),
      ),
      body: Center(
        child: Image.network('https://http.cat/$code')
        // , loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        //   if (loadingProgress == null) return child;
        //   return Center(
        //     child: CircularProgressIndicator(
        //       value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
        //     ),
        //   );
        // }, errorBuilder: (context, object, stackTrace) {
        //   return Text('Error: Invalid status code');
        // }),
      ),
    );
  }
}
// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

