import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

// TODO add dependencies
// TODO add comment.g.dart as part


@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body; 

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return _$CommentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentToJson(this);
  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class
  final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> commentsJson = jsonDecode(response.body);
    return commentsJson.map((json) => Comment.fromJson(json)).toList();
  }

  throw Exception('Failed to load comments');
}
