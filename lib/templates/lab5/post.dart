import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  //http://jsonplaceholder.typicode.com/posts

  final int userId;
  final String id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body, });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
      data['userId'] = this.userId;
      data['id'] = this.id;
      data['title'] = this.title;
      data['body'] = this.body;
      return data;
  }
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  return [];
}
