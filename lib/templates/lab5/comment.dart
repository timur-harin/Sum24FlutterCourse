// TODO add dependencies
// TODO add comment.g.dart as part
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'comment.g.dart';
@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;
  Comment(this.postId, this.id, this.name, this.email, this.body);
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // Using fabric from class
  final response = await http.get("http://jsonplaceholder.typicode.com/comments/1" as Uri);
  final jsonData = response.body;
  final parsedJson = jsonDecode(jsonData);
  final comment = Comment.fromJson(parsedJson);
  return [comment];
}
