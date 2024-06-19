// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
  const factory User({
    required int id, 
    required String name, 
    required String username,
    required String email, 
    required Map<String, dynamic> address,
    required String phone,
    required String website,
    required Map<String, dynamic> company,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}


Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
}
