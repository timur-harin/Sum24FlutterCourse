import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'comment.g.dart';


@JsonSerializable()
class Comment {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment(this.postId, this.id, this.name, this.email, this.body);
  factory Comment.fromJson(Map<String, dynamic> json) {
    return _$CommentFromJson(json);
  }

  Map<String, dynamic> toJson () => _$CommentToJson(this);

}

Future<List<Comment>> fetchComments() async {
  var response = await http.get(Uri.parse("http://jsonplaceholder.typicode.com/comments"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
  }
  return [];
}

Future<Comment> getRandomComment() async {
  final _random = Random();
  var comments = await fetchComments();

  return comments[_random.nextInt(comments.length)];
}
