// TODO add dependencies
// TODO add comment.g.dart as part

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
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
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}


Future<List<Comment>> fetchComments() async {
  final response = await get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));
  if (response.statusCode == 200) {
    List<Comment> comments = (jsonDecode(response.body) as List)
        .map((json) => Comment.fromJson(json))
        .toList();
    return comments;
  } else {
    throw Exception('Failed to load comments');
  }
}
