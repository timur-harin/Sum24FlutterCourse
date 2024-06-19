import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
 // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts

 Post({required this.userId, required this.id, required this.title, required this.body});

 factory Post.fromJson(Map<String, dynamic> json) {
  return Post(
   userId: json['userId'],
   id: json['id'],
   title: json['title'],
   body: json['body'],
  );
 }

 Map<String, dynamic> toJson() {
  return {
   'userId': userId,
   'id': id,
   'title': title,
   'body': body
  };
 }
}

Future<List<Post>> fetchPosts() async {
  final List<Post> posts = [];

  final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
  final response = await get(url);

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(response.body);
    for (var json in jsonResponse) {
      posts.add(Post.fromJson(json));
    }
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }

  return posts;
}