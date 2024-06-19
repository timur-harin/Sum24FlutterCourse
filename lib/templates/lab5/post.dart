// TODO add dependencies
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'post.g.dart';

@JsonSerializable()
class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  final int userId;
  final int id;
  final String title;
  final String body;
  Post(this.userId, this.id, this.title, this.body);
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  final response = await http.get("http://jsonplaceholder.typicode.com/posts/1" as Uri);
  final jsonData = response.body;
  final parsedJson = jsonDecode(jsonData);
  final post = Post.fromJson(parsedJson);
  return [post];
}
