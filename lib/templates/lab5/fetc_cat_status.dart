import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cat_status_code.dart';

Future<List<CatStatusCode>> fetchCatStatusCodes() async {
  final response = await http.get(Uri.parse('https://catstatusapi.com/statuses'));

  if (response.statusCode == 200) {
    final List<dynamic> statusJson = jsonDecode(response.body);
    return statusJson.map((json) => CatStatusCode.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load cat status codes');
  }
}
