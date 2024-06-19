// TODO add dependencies
import 'dart:convert';

import 'package:http/http.dart';

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson(Post post) {
    Map<String, dynamic> result = {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body};
    return result;
  }
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  final response = await get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));

  if(response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    List<Post> posts = [];
    for(Map<String, dynamic> item in jsonList){
      posts.add(Post.fromJson(item));
    }
    return posts;
  } else {
    throw Exception("Error receiving data");
  }
}
