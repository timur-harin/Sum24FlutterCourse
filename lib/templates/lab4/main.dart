import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final responseProvider = StateProvider<String>((ref) => '');
  final resultProvider = StateNotifierProvider<ResultNotifier, String>((ref) => ResultNotifier());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                final counterProvider = StateProvider<int>((ref) => 0);
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read(counterProvider).state++;
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
                var response = await http.get(url);
                if (response.statusCode == 200) {
                  print('Response body: ${response.body}');
                } else {
                  print('Request failed with status: ${response.statusCode}.');
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                Dio dio = Dio();
                final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
                final response = await dio.get(url.toString());

                late String answer;
                if (response.statusCode == 200) {
                  answer = response.data.toString();
                } else {
                  answer =
                  'Request failed with status: ${response.statusCode}.';
                }
                context.read().updateResult(answer, 4);
              },
              child: Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  final dio = Dio();

  Future<String> fetchDataDio() async {
    var response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    if (response.statusCode == 200) {
      return response.data.toString();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
class ResultNotifier extends StateNotifier<String> {
  ResultNotifier() : super('');

  void updateResult(String result, int taskNumber) {
    state = 'Task $taskNumber: $result';
  }
}