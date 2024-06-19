import 'dart:convert';
import 'dart:math';


import 'package:http/http.dart' as http;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

Future<int> main() async {
  var users = await fetchUsers();
  print(users.first.website);
  return 0;
}

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
    required String website,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json)
    => _$UserFromJson(json);
}


Future<List<User>> fetchUsers() async {
  var response = await http.get(Uri.parse("http://jsonplaceholder.typicode.com/users/"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  }

  return [];
}

Future<User> getRandomUser() async {
  final _random = Random();
  var users = await fetchUsers();

  return users[_random.nextInt(users.length)];
}
