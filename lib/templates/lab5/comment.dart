// TODO add dependencies
// TODO add comment.g.dart as part
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
    final int id;
  final int postId;
  final String name;
  final String email;
  final String body;
    Comment(this.id, this.postId, this.name, this.email, this.body);
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

        Map<String, dynamic> toJson() => _$CommentToJson(this);


  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}



Future<List<Comment>> fetchComments() async {
    // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class
  final url = Uri.parse('http://jsonplaceholder.typicode.com/comments');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> commentsJson = json.decode(response.body);
    return commentsJson.map((json) => Comment.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}

