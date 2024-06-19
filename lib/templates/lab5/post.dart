import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Post {
  Post(this.userId, this.id, this.title, this.body);

  final int userId;
  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    (json['userId'] as num).toInt(),
    (json['id'] as num).toInt(),
    json['title'] as String,
    json['body'] as String,
  );
  Map<String, dynamic> toJson(Post post) => <String, dynamic>{
    'userId': post.userId,
    'id': post.id,
    'title': post.title,
    'body': post.body,
  };
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((postJson) => Post.fromJson(postJson)).toList();
  } else {
    throw Exception('Failed to fetch posts');
  }
}