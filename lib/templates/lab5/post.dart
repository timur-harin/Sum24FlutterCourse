// TODO add dependencies
import 'package:http/http.dart' as http;

/*class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts

  factory Post.fromJson(Map<String, dynamic> json) {}

  factory Post.toJson(Post post) {}
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  return [];
}*/
import 'dart:convert';


class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<Post> posts = data.map((postJson) => Post.fromJson(postJson)).toList();
    return posts;
  } else {
    throw Exception('Failed to load posts');
  }
}