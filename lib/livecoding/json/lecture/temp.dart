import 'dart:convert';

import 'package:education/livecoding/json/lecture/data.dart';
import 'package:http/http.dart' as http;

void main() async {
  final todo = await getJson();

  deleteJson(todo);
}

Future<TODO> getJson() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final todo = TODO.fromJson(jsonDecode(response.body));
    return todo;
  } else {
    throw Exception('Failed to load TODO');
  }
}

void postJson(TODO todo) async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  print(todo.toJson());

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(todo.toJson()),
  );

  if (response.statusCode == 201) {
    print('TODO created');
    print(response.body);
  } else {
    throw Exception('Failed to create TODO');
  }
}

void putJson(TODO todo) async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  
  final response = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(todo.toJson()),
  );  

  if (response.statusCode == 200) {
    print('TODO updated');
    print(response.body);
  } else {
    throw Exception('Failed to update TODO');
  }
}


void patchJson(TODO todo) async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(todo.toJson()),
  );

  if (response.statusCode == 200) {
    print('TODO patched');
    print(response.body);
  } else {
    throw Exception('Failed to patch TODO');
  }
} 

void deleteJson (TODO todo) async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.delete(url);

  if (response.statusCode == 200) {
    print('TODO deleted');
  } else {
    throw Exception('Failed to delete TODO');
  }
}
