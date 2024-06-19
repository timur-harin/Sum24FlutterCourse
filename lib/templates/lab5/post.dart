// TODO add dependencies
import 'dart:convert';

import 'package:http/http.dart' as http;
class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
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

  // factory Post.toJson(Post post) {
  //   return <String, dynamic>{'userId': post.userId, 'id': post.id, 'title': post.title, 'body': post.body}
  // }
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  final url = Uri.parse('http://jsonplaceholder.typicode.com/posts');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> posts = jsonDecode(response.body);
    return posts.map((post) => Post.fromJson(post)).toList();
  }
  return [];
}
