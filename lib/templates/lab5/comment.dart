// TODO add dependencies
// TODO add comment.g.dart as part
import 'package:http/http.dart' as http;

import 'dart:convert';

class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  Comment.fromJson(Map<String, dynamic> json):
    postId = json['postId'],
    id = json['id'],
    name = json['name'],
    email = json['email'],
    body = json['body'];

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    
    Iterable it = jsonDecode(response.body);
    List<Comment> posts = List<Comment>.from(it.map((model) => Comment.fromJson(model)));
    return posts;
  } else {
    throw Exception('Failed to load post');
  }

  return [];
}
