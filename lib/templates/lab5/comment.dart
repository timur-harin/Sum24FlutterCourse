import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments({int start = 0, required int count}) async {
  const url = 'http://jsonplaceholder.typicode.com/comments';
  List<Comment> comments = [];
  for (int i = start; i < start + count; ++i) {
    comments.add(Comment.fromJson((await Dio().get('$url/$i')).data));
  }
  return comments;
}
