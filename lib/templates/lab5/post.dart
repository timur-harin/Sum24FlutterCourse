import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson(Post post) {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List<dynamic> postJson = json.decode(response.body) as List;
    return postJson.map((json) => Post.fromJson(json)).toList();
  } else {
    return [];
  }
}
