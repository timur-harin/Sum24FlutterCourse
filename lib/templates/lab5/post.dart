import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: (json['userId'] as num).toInt(),
        id: (json['id'] as num).toInt(),
        title: json['title'] as String,
        body: json['body'] as String,
      );

  Map<String, dynamic> toJson(Post post) => <String, dynamic>{
        'userId': post.userId,
        'id': post.id,
        'title': post.title,
        'body': post.body,
      };
}

Future<List<Post>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    List listResponse = json.decode(response.body);
    return listResponse.map((item) => Post.fromJson(item)).toList();
  } else {
    throw Exception('Error occured while loading Post');
  }
}
