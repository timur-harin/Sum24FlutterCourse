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
  const factory User({
    int? id,
    String? name,
    String? username,
    String? email,
    // Add other fields that match the JSON structure
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users/'));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((data) => User.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load users');
  }
}