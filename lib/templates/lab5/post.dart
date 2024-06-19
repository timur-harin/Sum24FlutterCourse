import 'dart:convert';
import 'package:http/http.dart' as http;

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
      body: json['body']
      );

  }

  factory Post.toJson(Post post) {

    return Post(
      userId: post.userId,
      id: post.id,
      title: post.title,
      body: post.body,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'userid' : userId,
      'id' : id,
      'title': title,
      'body': body,
    };
  }
}

Future<List<Post>> fetchPosts() async {
final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts')); 

if (response.statusCode == 200){
  List<dynamic> jsonData = json.decode(response.body);
  List<Post> posts = jsonData.map((jsonItem) => Post.fromJson(jsonItem)).toList();
    return posts;
}else{
  throw Exception('Failed to load posts');
  }

}
