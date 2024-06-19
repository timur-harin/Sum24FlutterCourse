// import 'dart:ffi'; 
import 'package:dio/dio.dart';
import 'dart:convert';

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);
  // Using fabric from class
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['body'] as String,
    );
  }

  factory Post.toJson(Post post) {
    return Post(
      post.userId,
      post.id,
      post.title,
      post.body,
    );
  }
}

Future<List<Post>> fetchPosts() async {
  // // Using fabric from class
  Dio dio = Dio();

  final response = await dio.get('https://jsonplaceholder.typicode.com/posts');

  if (response.statusCode == 200) {
    return (response.data as List)
        .map((i) => Post.fromJson(i))
        .toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
