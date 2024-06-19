// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
  factory User({
    int? id,
    String? name,
    String? username,
    String? email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}



Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users/'));

  if (response.statusCode == 200) {
    final List<dynamic> usersJson = json.decode(response.body) as List;
    return usersJson.map((jsonItem) => User.fromJson(jsonItem)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}