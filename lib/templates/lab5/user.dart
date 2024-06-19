import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
 const factory User({required int id,required  String name,required  String username,required  String email,required  Map<String, dynamic> address}) = _User;

 factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
 final List<User> users = [];

 final url = Uri.parse("https://jsonplaceholder.typicode.com/users");
 final response = await http.get(url);

 if (response.statusCode == 200) {
  final List<dynamic> jsonResponse = jsonDecode(response.body);
  for (var json in jsonResponse) {
   users.add(User.fromJson(json));
  }
 } else {
  throw Exception('OSHIBKA: ${response.statusCode}.');
 }

 return users;
}