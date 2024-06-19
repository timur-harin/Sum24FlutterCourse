// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required String phone,
    required String website,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);  
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
}

Future<List<User>> fetchUsers() async {
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/ 
  // Using fabric from class

  final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> users = jsonDecode(response.body);
    return users.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load users');
  };
}
