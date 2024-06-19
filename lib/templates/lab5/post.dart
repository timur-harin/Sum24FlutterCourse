import 'package:http/http.dart' as http;
import 'dart:convert'; 


// TODO add dependencies

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

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

  //factory Post.toJson(Post post) {}
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((post) => Post.fromJson(post)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
  // // Using fabric from class
  return [];
}
