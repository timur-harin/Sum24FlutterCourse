import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart'  as http;

//g.dart as part
part 'user.g.dart';
//user.freezed.dart as part
part 'user.freezed.dart';


@freezed
class User with _$User {
  //http://jsonplaceholder.typicode.com/users/
  
  factory User(
    {
      required int id,
      required String name,
      required String username,
      required String email,
      required String phone,
      required String website,
    }
  ) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
  //http://jsonplaceholder.typicode.com/users/ 

  final List<User> usersList = [];

  final response = await http.get(Uri.parse("http://jsonplaceholder.typicode.com/users/"));

  if(response.statusCode == 200) {
    List<dynamic> users = jsonDecode(response.body);
    for (var user in users) {
      usersList.add(User.fromJson(user));
    }
    return usersList;
  } else {
    throw Exception('Failed to load users. Status: ${response.statusCode}');
  }
}
