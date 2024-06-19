// TODO add dependencies
// TODO add comment.g.dart as part

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments

  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment(this.postId, this.id, this.name, this.email, this.body);

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      json['postId'] as int,
      json['id'] as int,
      json['name'] as String,
      json['email'] as String,
      json['body'] as String,
    );
  }

  factory Comment.toJson(Comment comment) {
    return Comment(
      comment.postId,
      comment.id,
      comment.name,
      comment.email,
      comment.body,
    );
  }

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class

  Dio dio = Dio();
  final response = await dio.get('https://jsonplaceholder.typicode.com/comments');
  if (response.statusCode == 200) {
    return (response.data as List)
        .map((i) => Comment.fromJson(i))
        .toList();
  } else {
    throw Exception('Failed to load comments');
  }
}
