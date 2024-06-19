import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
  final res = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users/'));
  if (res.statusCode == 200) {
    List jsonResponse = json.decode(res.body);
    return jsonResponse.map((item) => User.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}