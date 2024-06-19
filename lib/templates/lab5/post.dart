import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  final String body;
  final int userId;

  Post(
      {required this.id,
      required this.title,
      required this.body,
      required this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
    );
  }

  factory Post.toJson(Post post) {
    return Post(
      id: post.id,
      title: post.title,
      body: post.body,
      userId: post.userId,
    );
  }
}

Future<List<Post>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => Post.fromJson(data)).toList();
  } else {
    throw Exception('No posts, Sir');
  }
}