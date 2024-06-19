// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part

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
    required Address address,
    required String phone,
    required String website,
  }) = _User;
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    required Geo geo,
  }) = _Address;
  factory Address.fromJson(Map<String, Object?> json) =>
      _$AddressFromJson(json);
}

@freezed
class Geo with _$Geo {
  const factory Geo({required String lat, required String lng}) = _Geo;
  factory Geo.fromJson(Map<String, Object?> json) => _$GeoFromJson(json);
}

Future<List<User>> fetchUsers() async {
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/
  // Using fabric from class

  Dio dio = Dio();
  final response = await dio.get('http://jsonplaceholder.typicode.com/users/');
  List<User> users = [];
  for (dynamic user in response.data) {
    users.add(User.fromJson(user));
  }
  return users;
}

// void main() async {
//   final users = await fetchUsers();
//   for (dynamic user in users) {
//     print(user.id.toString() + ' ' + user.name + ' ' + user.address.city);
//   }
// }
