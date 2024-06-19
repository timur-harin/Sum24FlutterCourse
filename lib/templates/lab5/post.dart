import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  int id;
  String title;
  String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List<Post> posts = (jsonDecode(response.body) as List)
      .map((json) => Post.fromJson(json))
      .toList();
    return posts;
  } else {
    throw Exception('Failed to load posts');
  }
}