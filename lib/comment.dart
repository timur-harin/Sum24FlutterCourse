// // TODO add dependencies
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

// // TODO add comment.g.dart as part
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
    this.postId,
    this.id,
    this.name,
    this.body,
    this.email,
  );

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
  // For me only `flutter pub run build_runner build` works for some reason...
}

Future<List<Comment>> fetchComments() async {
  // // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Comment> comments =
        body.map((dynamic item) => Comment.fromJson(item)).toList();
    return comments;
  } else {
    throw Exception('Failed to load posts');
  }
}
