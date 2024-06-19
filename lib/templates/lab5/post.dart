import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  int userId;
  late int id;
  late String title;
  late String body;
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts

  Post._create({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post._create(userId: json["userId"], id: json["id"], title: json["title"], body: json["body"]);
  }

  Map<String, dynamic> toJson(Post post) {
    return {
      "userId": post.userId,
      "id": post.id,
      "title": post.title,
      "body": post.body
    };
  }
}

Future<List<Post>> fetchPosts() async {
  var response = await http.get(
      Uri.parse("http://jsonplaceholder.typicode.com/posts"));
  List<Post> posts = [];
  for (var post in json.decode(response.body)) {
    posts.add(Post.fromJson(post));
  }
  return posts;
}
