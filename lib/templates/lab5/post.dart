// TODO add dependencies
import 'dart:convert';
import 'package:http/http.dart' as http;


class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({required this.id, required this.userId, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
}}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    List<dynamic> posts = jsonDecode(response.body);
    return posts.map((post) => Post.fromJson(post)).toList();
  }
  else{
    throw Exception('Failed to load posts');
  }
}
