import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment(this.postId, this.id, this.name, this.email, this.body);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson(Comment comment) => _$CommentToJson(comment);
}

Future<List<Comment>> fetchComments() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((commentJson) => Comment.fromJson(commentJson)).toList();
  } else {
    throw Exception('Failed to fetch comments');
  }
}
