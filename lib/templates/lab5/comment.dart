import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


part 'comment.g.dart';


@JsonSerializable()
class Comment {
  int postId;
  int id;
  String name;
  String email;
  String body;


  Comment(this.postId, this.id, this.name, this.email, this.body);

  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}

Future<List<Comment>> fetchComments() async {
  var response = await http.get(
      Uri.parse("http://jsonplaceholder.typicode.com/comments"));
  List<Comment> comments = [];
  for (var comment in json.decode(response.body)) {
    comments.add(Comment.fromJson(comment));
  }
  return comments;
}
