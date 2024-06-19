// TODO add dependencies

import 'dart:convert';

import 'package:http/http.dart';

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
Future<List<Post>> fetchPosts() async {
  final response = await get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    List<Post> posts = (jsonDecode(response.body) as List)
        .map((json) => Post.fromJson(json))
        .toList();
    return posts;
  } else {
    throw Exception('Failed to load posts');
  }
}
