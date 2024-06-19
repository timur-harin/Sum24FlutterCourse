import 'dart:convert';

import 'package:http/http.dart' as http;


class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  // DONE
  // task 1 to make this class for url http://jsonplaceholder.typicode.com/posts

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
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
  // DONE 
  // task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // Using fabric from class
  final url = Uri.parse("http://jsonplaceholder.typicode.com/posts");
  final response = await http.get(url);
  
  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
