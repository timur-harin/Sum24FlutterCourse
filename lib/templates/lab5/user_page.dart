import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'user.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late Future<List<User>> _users;

  @override
  void initState() {
    super.initState();
    _users = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: _users,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.username),
                    leading: CircleAvatar(
                      child: Text(user.name[0]),
                    ),
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