import 'package:flutter/material.dart';
import 'comment.dart';
import 'error_status_image.dart';

class CommentsPage extends StatelessWidget {
  final Future<List<Comment>> comments = fetchComments();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments fetched using API'),
      ),
      body: FutureBuilder<List<Comment>>(
        future: comments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text('Error: ${snapshot.error}'),
                    errorStatusImage('404')
                  ],
                );
              }
            }
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].body),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}