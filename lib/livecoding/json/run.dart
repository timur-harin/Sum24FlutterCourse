import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {

}



Future<void> fetchPosts() async {
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List<dynamic> posts = jsonDecode(response.body);
    print(posts);
  } else {
    throw Exception('Failed to load posts');
  }
}


Future<void> createPost() async {
  final response = await http.post(
    Uri.parse('http://jsonplaceholder.typicode.com/posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    }),
  );

  if (response.statusCode == 201) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}


Future<void> updatePost(int postId) async {
  final response = await http.put(
    Uri.parse('http://jsonplaceholder.typicode.com/posts/$postId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'id': postId,
      'title': 'updated title',
      'body': 'updated body',
      'userId': 1,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update post');
  }
}

Future<void> patchPost(int postId) async {
  final response = await http.patch(
    Uri.parse('http://jsonplaceholder.typicode.com/posts/$postId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'title': 'patched title',
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to patch post');
  }
}

Future<void> deletePost(int postId) async {
  final response = await http.delete(
    Uri.parse('http://jsonplaceholder.typicode.com/posts/$postId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    print('Post deleted');
  } else {
    throw Exception('Failed to delete post');
  }
}
