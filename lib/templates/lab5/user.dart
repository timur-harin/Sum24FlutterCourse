import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
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