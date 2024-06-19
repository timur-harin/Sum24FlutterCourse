import 'package:http/http.dart';
import 'dart:convert';

class Post {
  //http://jsonplaceholder.typicode.com/posts

  final int userId;
  final int id;
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
  // Task 1.2

  final List<Post> postsList = [];
  final response = await get(Uri.parse("http://jsonplaceholder.typicode.com/posts"));

  if (response.statusCode == 200) {
    List<dynamic> posts = jsonDecode(response.body);
    for (var post in posts) {
      postsList.add(Post.fromJson(post));
    }
    return postsList;
  } else {
    throw Exception('Failed to load posts. Status: ${response.statusCode}');
  }
}
