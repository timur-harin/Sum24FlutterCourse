// TODO add dependencies
import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  Post(this.userId, this.id, this.title, this.body);
  int userId, id;
  String title, body;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json['userId'] as int,
        json['id'] as int,
        json['title'] as String,
        json['body'] as String);
  }

  static Map<String, dynamic> toJson(Post post) {
    return <String, dynamic>{
        'userId' : post.userId,
        'id' : post.id,
        'title' : post.title,
        'body' : post.body
    };
  }
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  List<Post> fetchedPosts = [];
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    final posts = jsonDecode(response.body);
    for (final post in posts){
      fetchedPosts.add(Post.fromJson(post),);
    }
  }
  return fetchedPosts;
}

Future<void> main() async {
  final fetchedPosts = await fetchPosts();
  print(Post.toJson(fetchedPosts[89]));
}
