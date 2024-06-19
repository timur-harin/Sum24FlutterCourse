// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required Address address,
    required String phone,
    required String website,
    required Company company,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street'],
        suite: json['suite'],
        city: json['city'],
        zipcode: json['zipcode'],
        geo: Geo.fromJson(json['geo']),
      );
  Map<String, dynamic> toJson() {
  return {
    'street': street,
    'suite': suite,
    'city': city,
    'zipcode': zipcode,
    'geo': geo
      };
    }
}

class Geo {
  final String lat;
  final String lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json['lat'],
        lng: json['lng'],
      );
      Map<String, dynamic> toJson() {
  return {
    'lat': lat,
    'lng': lng
      };
    }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json['name'],
        catchPhrase: json['catchPhrase'],
        bs: json['bs'],
      );
      Map<String, dynamic> toJson() {
  return {
    'name': name,
    'catchPhrase': catchPhrase,
    'bs': bs
      };
    }
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
