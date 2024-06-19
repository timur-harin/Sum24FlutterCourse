// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
       int? id,
   String? name,
   String? email,
   String? username,
    
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List<dynamic> userJson = jsonDecode(response.body) as List;
    return userJson.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
