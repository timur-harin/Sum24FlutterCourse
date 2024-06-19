// TODO add dependencies
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

@freezed
class User with _$User {
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
  const FactoryUser({
    required String username,
    required String name,
    required String email,
  }) = _User;
}

Future<List<User>> fetchUsers() async {
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/ 
  // Using fabric from class
final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));
  
  if (response.statusCode == 200) {
    Iterable it = jsonDecode(response.body);
    List<User> posts = List<User>.from(it.map((model) => User.fromJson(model)));
    return posts;
  } else {
    throw Exception('Failed to load post');
  }
}
