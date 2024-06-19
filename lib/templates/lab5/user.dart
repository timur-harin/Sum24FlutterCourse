
import 'dart:convert';
import 'package:http/http.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    int? id,
    required String name,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
  final response = await get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List<User> users = (jsonDecode(response.body) as List)
       .map((json) => User.fromJson(json))
       .toList();
    return users;
  } else {
    throw Exception('Failed to load users');
  }
}