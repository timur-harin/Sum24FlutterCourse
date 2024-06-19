import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  int id;
  String title;
  String body;

  Post({required this.id, required this.title, required this.body});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

Future<List<Post>> fetchPosts() async {
  var url = Uri.parse('http://jsonplaceholder.typicode.com/posts');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List<Post> posts = [];
    List<dynamic> data = jsonDecode(response.body);
    for (var postJson in data) {
      Post post = Post.fromJson(postJson);
      posts.add(post);
    }
    return posts;
  } else {
    throw Exception('failed to load posts');
  }
}
