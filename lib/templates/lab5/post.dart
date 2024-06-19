// TODO add dependencies
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) :
    userId = json['userId'],
    id = json['id'],
    title = json['title'],
    body = json['body'];
  

  Map<String, dynamic> toJson(Post post) => {
    'userId': userId,
    'id': id,
    'title': title,
    'body': body
  };
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
  
  if (response.statusCode == 200) {
    Iterable it = jsonDecode(response.body);
    List<Post> posts = List<Post>.from(it.map((model) => Post.fromJson(model)));
    return posts;
  } else {
    throw Exception('Failed to load post');
  }
}
