import 'package:education/templates/lab5/user.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  final Future<List<User>> Function() fetchData;

  const UsersPage(this.fetchData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name),
                  subtitle: Text(users[index].email),
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