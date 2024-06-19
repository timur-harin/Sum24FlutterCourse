// TODO add dependencies
// TODO add comment.g.dart as part

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


part 'comment.g.dart';

@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  Comment(this.postId, this.id, this.name, this.email, this.body);
  int postId, id;
  String name, email, body;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  static Map<String, dynamic> toJson(Comment comment) => _$CommentToJson(comment);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class

  List<Comment> fetchedComments = [];
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));
  if (response.statusCode == 200) {
    final comments = jsonDecode(response.body);
    for (final comment in comments){
      fetchedComments.add(Comment.fromJson(comment));
    }
  }
  return fetchedComments;
}

Future<void> main() async {
  final fetchedComments = await fetchComments();
  print(Comment.toJson(fetchedComments[11]));
}
