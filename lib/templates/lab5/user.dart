// TODO add dependencies
import 'package:education/templates/lab2/lab2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
// TODO add user.g.dart as part
part 'user.g.dart';
part 'user.freezed.dart';

// TODO add user.freezed.dart as part

@freezed
class User with _$User {
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

  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
}

Future<List<User>> fetchUsers() async {
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/ 
  // Using fabric from class

  return [];
}
