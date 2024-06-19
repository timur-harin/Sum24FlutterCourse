import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'user.freezed.dart';
part 'user.g.dart';


@Freezed(makeCollectionsUnmodifiable: false)
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required Map<String, Object?> address,
    required String phone,
    required String website,
    required Map<String, Object?> company,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);


// TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
}

Future<List<User>> fetchUsers() async {
  var response = await http.get(
      Uri.parse("http://jsonplaceholder.typicode.com/users/"));
  List<User> users = [];

  for (var user in json.decode(response.body)) {
    users.add(User.fromJson(user));
  }
  return users;
}