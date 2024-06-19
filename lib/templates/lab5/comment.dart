// TODO add dependencies
// TODO add comment.g.dart as part

import 'package:json_annotation/json_annotation.dart';
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
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class

  Dio dio = Dio();
  final response =
      await dio.get('http://jsonplaceholder.typicode.com/comments');
  List<Comment> comments = [];
  for (dynamic comment in response.data) {
    comments.add(Comment.fromJson(comment));
  }
  return comments;
}

// void main() async {
//   final comments = await fetchComments();
//   for (dynamic comment in comments) {
//     print(comment.id.toString() + ' ' + comment.email);
//   }
// }
