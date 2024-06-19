// TODO add dependencies
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
// TODO add comment.g.dart as part
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int userId;
  final int id;
  final String title;
  final String email;
  final String body;

  Comment({required this.userId, required this.id, required this.title, required this.email, required this.body});
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);


  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));
  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    return body.map((dynamic item) => Comment.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}
