import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;




class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json["userId"], json["id"], json["title"], json["body"]);
  }

  Map<String, dynamic> toJson() {
    return {"userId": userId, "id": id, "title": title, "body": body};
  }
}

Future<List<Post>> fetchPosts() async {
  var response = await http.get(Uri.parse("http://jsonplaceholder.typicode.com/posts"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((post) => Post.fromJson(post)).toList();
  }
  return [];
}

Future<Post> getRandomPost() async {
  final _random = Random();
  var posts = await fetchPosts();

  return posts[_random.nextInt(posts.length)];
}
