// // TODO add dependencies
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// // TODO add user.g.dart as part
part 'user.g.dart';

// // TODO add user.freezed.dart as part
part 'user.freezed.dart';

@freezed
class User with _$User {
  // // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/

  const factory User(
      {required int id,
      required String name,
      required String username,
      required String email,
      required Map<String, dynamic> address,
      required String phone,
      required String website,
      required Map<String, String> company,}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Future<List<User>> fetchUsers() async {
  // // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/
  // // Using fabric from class
  
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<User> comments =
        body.map((dynamic item) => User.fromJson(item)).toList();
    return comments;
  } else {
    throw Exception('Failed to load posts');
  }
}
