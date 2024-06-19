import 'package:flutter/material.dart';
import 'comment.dart';

class CommentsPage extends StatefulWidget {
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late Future<List<Comment>> _comments;

  @override
  void initState() {
    super.initState();
    _comments = fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Center(
        child: FutureBuilder<List<Comment>>(
          future: _comments,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final comment = snapshot.data![index];
                  return ListTile(
                    title: Text(comment.name),
                    subtitle: Text(comment.body),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}