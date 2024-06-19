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
    String? username,
    String? email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
}

Future<List<User>> fetchUsers() async {
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/
  // Using fabric from class
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users/'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => User.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
