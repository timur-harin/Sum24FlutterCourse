// TODO add dependencies
import 'dart:convert';

import 'package:http/http.dart';
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

 Comment(this.postId, this.id, this.name, this.email, this.body);

 factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
 Map<String, dynamic> toJson() => _$CommentToJson(this);
}

Future<List<Comment>> fetchComments() async {
 final List<Comment> comments = [];

 final url = Uri.parse("https://jsonplaceholder.typicode.com/comments");
 final response = await get(url);

 if (response.statusCode == 200) {
  final List<dynamic> jsonResponse = jsonDecode(response.body);
  for (var json in jsonResponse) {
   comments.add(Comment.fromJson(json));
  }
 } else {
  throw Exception('Request failed with status: ${response.statusCode}.');
 }

 return comments;
}