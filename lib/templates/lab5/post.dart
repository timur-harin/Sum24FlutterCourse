// TODO add dependencies

import 'dart:convert';
import 'package:http/http.dart' as http;
class Post {

  int userId;
  int id;
  String title;
  String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,});
  

  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts

  factory Post.fromJson(Map<String, dynamic> json)=> Post(
    userId: json['userId'],
    id: json['id'],
    title: json['title'],
    body: json['body'],
  );
    

  Map<String, dynamic> toJson(Post post) {
    return <String, dynamic>{
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
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body).map<Post>((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
