// TODO add dependencies
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
// TODO add comment.g.dart as part
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((e) => Comment.fromJson(e))
        .toList();
  } else{
    throw Exception('Failed to load comments');
  }
}
