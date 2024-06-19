// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'user.g.dart';
part 'user.freezed.dart';


@freezed
class User with _$User {
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
  
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required String phone,
    required String website,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users/'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(response.body);
    List<User> users = jsonResponse.map((user) => User.fromJson(user)).toList();
    return users;
  } else {
    throw Exception('Failed to load users');
  }
}
