// TODO add dependencies
// TODO add comment.g.dart as part
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';
@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  int postId;
  int id;
  String name;
  String email;
  String body;
  Comment(this.postId,  this.id,  this.name,  this.email,  this.body);
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class
  final url = Uri.parse('http://jsonplaceholder.typicode.com/comments');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> comments = jsonDecode(response.body);
    return comments.map((comment) => Comment.fromJson(comment)).toList();
  }
  return [];
}
