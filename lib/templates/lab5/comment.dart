// TODO add dependencies

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
// TODO add comment.g.dart as part

part 'comment.g.dart';


@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return _$CommentFromJson(json);
  }

  Map<String, dynamic> toJson(Comment comment) => _$CommentToJson(comment);
  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class
  final url = Uri.parse('http://jsonplaceholder.typicode.com/comments');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body).map<Comment>((json) => Comment.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}
