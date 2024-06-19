import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.id,
      required this.title,
      required this.body,
      required this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson(Post post) {
    return <String, dynamic>{
      'id': post.id,
      'title': post.title,
      'body': post.body,
      'userId': post.userId
    };
  }
}

Future<List<Post>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Post.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load post');
  }
}
