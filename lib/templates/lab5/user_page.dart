import 'package:flutter/material.dart';
import 'error_status_image.dart';
import 'user.dart';
import 'representation_page.dart';

class UsersPage extends StatelessWidget {
  final Future<List<User>> users = fetchUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users fetched using API'),
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text('Error: ${snapshot.error}'),
                  errorStatusImage('404')
                ],
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name ?? 'Default Name'),
                  subtitle: Text(snapshot.data![index].email ?? 'Default Email'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailPage(user: snapshot.data![index]),
                      ),
                    );
                  },
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