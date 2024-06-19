import 'package:education/templates/lab5/comment.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  final Future<List<Comment>> Function() fetchData;

  const CommentsPage(this.fetchData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Comment> comments = snapshot.data!;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index].name),
                  subtitle: Text(comments[index].email),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}