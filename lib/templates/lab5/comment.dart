// TODO add dependencies

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart';
// TODO add comment.g.dart as part

part 'comment.g.dart';


@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({required this.postId, required this.id, required this.name, required this.email, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class

  final response = await get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    final List<dynamic> json = jsonDecode(response.body);
    List<Comment> comments = [];
    for(Map<String, dynamic> item in json){
      comments.add(Comment.fromJson(item));
    }
    return comments;
  } else {
    throw Exception("Error receiving data");
  }
}
