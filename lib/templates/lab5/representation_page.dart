import 'package:flutter/material.dart';
import 'post.dart';
import 'user.dart';

class DetailPage extends StatelessWidget {
  final Post post;

  DetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(post.body),
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final User user;

  UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Name: ${user.name ?? 'N/A'}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${user.name}"),
            Text("Username: ${user.username}"),
            Text("Email: ${user.email}"),
          ],
        ),
      ),
    );
  }
}