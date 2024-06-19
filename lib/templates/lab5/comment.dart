import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// TODO add comment.g.dart as part

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
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
    required this.body
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Comment.fromJson(json)).toList();
  } else {
    throw Exception("bebebe");
  }
}
