// TODO add dependencies
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
// TODO add user.g.dart as part
part 'user.g.dart';
// TODO add user.freezed.dart as part
part 'user.freezed.dart';




@freezed
class User with _$User {
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
  factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    // Add other fields as per the API response
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/ 
  // Using fabric from class
    final response = await get(Uri.parse('http://jsonplaceholder.typicode.com/users/'));
  
  if (response.statusCode == 200) {
    final List<dynamic> json = jsonDecode(response.body);
    List<User> users = [];
    for(Map<String, dynamic> item in json){
      users.add(User.fromJson(item));
    }
    return users;
  } else {

    throw Exception("Error receiving data");
  }
}
