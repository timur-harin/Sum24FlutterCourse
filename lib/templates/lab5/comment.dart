// TODO add comment.g.dart as part
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int userId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({required this.userId, required this.id, required this.name, required this.email, required this.body});

    factory Comment.fromJson(Map<String, dynamic> json) {
      return Comment(
        userId: json['userId'], 
        id: json['id'], 
        name: json['name'], 
        email: json['email'], 
        body: json['body'],
      );
    }

    Map<String, dynamic> toJson() => _$CommentToJson(this);

}

Future<List<Comment>> fetchComments() async {
  final url = Uri.parse('http://jsonplaceholder.typicode.com/comments');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body); 
    return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
  } else {
    throw Exception("Failed to load comments");
  }

}
