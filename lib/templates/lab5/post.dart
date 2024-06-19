import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Post {
  Post({required this.userId, required this.id, required this.title, required this.body});
  final int userId;
  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) {
      final int userId = json['userId'];
      final int id = json['id'];
      final String title = json['title'];
      final String body = json['body'];
      return Post(userId: userId, id: id, title: title, body: body);

  }

  static Map<String, dynamic> toJson(Post post) {
    return{
      'userId': post.userId,
      'id': post.id,
      'title': post.title,
      'body': post.body,
    };
    }

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class

   final url = Uri.parse('http://jsonplaceholder.typicode.com/posts');
  final response = await http.get(url);


  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception("Failed to load posts");
  }
  return [];

}
}