// TODO add dependencies
import 'dart:convert';

import 'package:dio/dio.dart';

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  int userId;
  int id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json['userId'], json['id'], json['title'], json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  Dio dio = Dio();
  final response = await dio.get('http://jsonplaceholder.typicode.com/posts');
  List<Post> posts = [];
  for (dynamic post in response.data) {
    posts.add(Post.fromJson(post));
  }
  return posts;
}

// void main() async {
//   final posts = await fetchPosts();
//   for (dynamic post in posts) {
//     print(post.body);
//   }
// }
