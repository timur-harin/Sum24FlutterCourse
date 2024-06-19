import 'dart:convert';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  //http://jsonplaceholder.typicode.com/comments

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment(
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  );

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  // Do not forget to run 'dart run build_runner build' —> Ok!
}

Future<List<Comment>> fetchComments() async {
  final List<Comment> commentsList = [];

  final response = await get(Uri.parse("http://jsonplaceholder.typicode.com/comments"));

  if (response.statusCode == 200) {
    List<dynamic> comments = jsonDecode(response.body);
    for (var comment in comments) {
      commentsList.add(Comment.fromJson(comment));
    }
    return commentsList;
  } else {
    throw Exception('Failed to load comments. Status: ${response.statusCode}');
  }
}
