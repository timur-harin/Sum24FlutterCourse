import 'package:http/http.dart' as http;
import 'dart:convert';

class Comment {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

//url http://jsonplaceholder.typicode.com/comments
Future<List<Comment>> fetchComments() async {
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Comment.fromJson(json)).toList();
  } else {
    throw Exception("Cannot Decode");
  }
}
