// TODO add dependencies

import 'dart:convert';

import 'package:http/http.dart' as http;

// TODO add comment.g.dart as part

// part 'comment.g.dart';


class Comment {
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
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments

  final url = Uri.parse('http://jsonplaceholder.typicode.com/comments');

  final response = await http.get(url);

  final List<dynamic> comments = jsonDecode(response.body);
  return comments.map((json) => Comment.fromJson(json)).toList();

  // Using fabric from class
}
