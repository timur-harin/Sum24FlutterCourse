import 'dart:async';

// import 'http.dart';
import 'package:dio/dio.dart';

// import '';
void main() {
  getJson();
}

// void getJson() {
//   final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");

//   final response = get(url).then((response)){
//     print(response.body);
//     print("test");
//   };

// }

// void getJson ()  async{
//   final url = Uri.parse("https://jsonplaceholder.typicode.com/post/1");

//   final response = await get(url);
//     print(response.body);
//         print("test");

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     print("test");
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     print("test");

//   }
// }

void getJson() async {
  final url = Uri.parse("https://jsonplaceholder.typicode.com/post/1");

  Dio dio = Dio();

  final response = await get(url);
  print(response.body);
  print("test");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("test");
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("test");
  }
}
