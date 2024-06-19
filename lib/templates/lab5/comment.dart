// TODO add dependencies
// TODO add comment.g.dart as part
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'comment.g.dart';


@JsonSerializable()
class Comment {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
Future<List<Comment>> fetchComments() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    List<dynamic> commentJson = jsonDecode(response.body) as List;
    return commentJson.map((json) => Comment.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
