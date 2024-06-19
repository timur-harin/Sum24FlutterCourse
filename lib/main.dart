// Use these dependencies for your classes
import 'dart:convert';
// import 'package:education/livecoding/json/freezed/serialization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'post.dart';
import 'comment.dart';
import 'user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApplication());
}

// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

final Map<String, String> routes = {
  "/home": "/home",
  "/comments": "/comments",
  "/posts": "/posts",
  "/user": "/user"
};

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (context) => ProviderScope(child: HomePage()),
        "/posts": (context) => ProviderScope(child: PostsPage()),
        "/comments": (context) => ProviderScope(child: CommentsPage()),
        "/user": (context) => ProviderScope(child: UserPage()),
      },
      initialRoute: "/home",
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const spacer = const SizedBox(
      height: 16,
    );

    return Scaffold(
        appBar: AppBar(title: const Text("JSON parser demo")),
        body: Center(
          child: Column(
            children: [
              FilledButton(
                onPressed: () => Navigator.of(context).pushNamed("/posts"),
                child: const Text("Posts"),
              ),
              spacer,
              FilledButton(
                onPressed: () => Navigator.of(context).pushNamed("/comments"),
                child: const Text("Comments"),
              ),
              spacer,
              FilledButton(
                onPressed: () => Navigator.of(context).pushNamed("/user"),
                child: const Text("User"),
              ),
            ],
          ),
        ));
  }
}

class PostsPage extends ConsumerWidget {
  final postsProvider = StateProvider<List<Post>?>((ref) => null);

  PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Task 1: Simple factory"),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              FilledButton(
                  onPressed: () async {
                    final posts = await fetchPosts();
                    ref.read(postsProvider.notifier).state = posts;
                  },
                  child: const Text("Get posts")),
              buildContent(context, ref),
            ],
          )),
        ));
  }

  Widget buildContent(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider);

    if (posts == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Text("No posts fetched, yet"),
      );
    }

    return Column(children: [
      for (var post in posts)
        Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("User id: ${post.userId}"),
                Text("Post id: ${post.id}"),
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  post.body,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        ),
    ]);
  }
}

class CommentsPage extends ConsumerWidget {
  final commentsProvider = StateProvider<List<Comment>?>((ref) => null);

  CommentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Task 2: json_serializable"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                FilledButton(
                    onPressed: () async {
                      final comments = await fetchComments();
                      ref.read(commentsProvider.notifier).state = comments;
                    },
                    child: const Text("Fetch comments")),
                buildContent(context, ref),
              ],
            ),
          ),
        ));
  }

  Widget buildContent(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(commentsProvider);

    if (comments == null) {
      return const Text("No comments fetched, yet");
    }

    return Column(children: [
      for (var comment in comments)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Post id: ${comment.postId}"),
                  Text("Id: ${comment.id}"),
                  Text("Email: ${comment.email}"),
                  Text(comment.body),
                ],
              ),
            ),
          ),
        )
    ]);
  }
}

class UserPage extends ConsumerWidget {
  UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
