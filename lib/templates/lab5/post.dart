// TODO add dependencies

import 'dart:convert';

import 'package:education/livecoding/json/run.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts

  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.body,
    required this.id,
    required this.title,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {

    return Post (
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );


  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}

Future<List<Post>> fetchPosts() async {
  final res = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
  if (res.statusCode == 200) {
    List jsonResponse = json.decode(res.body);
    return jsonResponse.map((item) => Post.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}






