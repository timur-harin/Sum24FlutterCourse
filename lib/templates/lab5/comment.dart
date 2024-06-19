import 'package:http/http.dart' as http;
import 'dart:convert';
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
  var url = Uri.parse('http://jsonplaceholder.typicode.com/comments');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<Comment> comments = [];
    List<dynamic> data = json.decode(response.body);

    for (var commentJson in data) {
      Comment comment = Comment.fromJson(commentJson);
      comments.add(comment);
    }

    return comments;
  } else {
    throw Exception('Failed to load comments');
  }
}
