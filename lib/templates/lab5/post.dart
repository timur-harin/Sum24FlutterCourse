// TODO add dependencies
import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
    final int userId; 
    final int id;
    final String title;
    final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson(Post post) {
    return {
      'userId': post.userId,
      'id': post.id,
      'title': post.title,
      'body': post.body,
    };
  }
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    final List<dynamic> postsJson = json.decode(response.body);
    return postsJson.map((i) => Post.fromJson(i)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
