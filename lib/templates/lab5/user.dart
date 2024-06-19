import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

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
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}


Future<List<User>> fetchUsers() async {
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/ 
  // Using fabric from class
  Dio dio = Dio();

  final response = await dio.get('https://jsonplaceholder.typicode.com/users/');
  if (response.statusCode == 200) {
    return (response.data as List)
        .map((i) => User.fromJson(i))
        .toList();
  } else {
    throw Exception('Failed to load users');
  }
}
