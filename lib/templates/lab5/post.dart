import 'package:dio/dio.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']);

  Map<String, dynamic> toJson(Post post) => <String, dynamic>{
        'userId': userId,
        'id': id,
        'title': title,
        'body': body
      };
}

Future<List<Post>> fetchPosts({int start = 0, required int count}) async {
  List<Post> posts = [];
  const url = 'http://jsonplaceholder.typicode.com/posts';
  for (int i = start; i < start + count; ++i) {
    posts.add(Post.fromJson((await Dio().get('$url/$i')).data));
  }
  return posts;
}
