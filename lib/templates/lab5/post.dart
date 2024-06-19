import 'dart:convert';
import 'package:http/http.dart' as http;


class Post {
  int? userId;
  int? id;
  String title;
  String body;

  Post({
    this.userId,
    this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  static Map<String, dynamic> toJson(Post post) {
    return {
      'userId': post.userId,
      'id': post.id,
      'title': post.title,
      'body': post.body,
    };
  }
}

Future<List<Post>> fetchPosts() async {
  final url = Uri.parse("http://jsonplaceholder.typicode.com/posts");
  final response = await http.get(url);
  
  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('OSHIBKA');
  }
}