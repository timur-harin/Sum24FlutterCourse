import 'package:http/http.dart' as http; // Importing the http package
import 'dart:convert'; // Importing dart:convert for jsonDecode

import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int id;
  String name;
  String email;
  String body;

  Comment({required this.id, required this.name, required this.email, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

Future<List<Comment>> fetchComments() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<Comment> comments = jsonResponse.map((json) => Comment.fromJson(json)).toList();
    return comments;
  } else {
    throw Exception('Failed to load comments');
  }
}