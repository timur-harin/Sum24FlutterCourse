import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

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
  final res = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));
  if (res.statusCode == 200) {
    List jsonResponse = json.decode(res.body);
    return jsonResponse.map((item) => Comment.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}