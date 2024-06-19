// TODO add dependencies

import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) {
    final userId = json['userId'];
    final id = json['id'];
    final title = json['title'];
    final body = json['body'];
    return Post(
      userId: userId,
      id: id,
      title: title,
      body: body,
    );
  }

  static Map<String, dynamic> toJson(Post post) {
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
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> posts = jsonDecode(response.body);
    return posts.map((post) => Post.fromJson(post)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
