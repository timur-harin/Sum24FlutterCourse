import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
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

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                // TODO
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterProvider.notifier).increment();
                print(ref.watch(counterProvider));
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await get(
                    Uri.parse('http://jsonplaceholder.typicode.com/albums/1'));
                if (response.statusCode == 200) {
                  print(response.body);
                } else {
                  print('Failed to fetch');
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                Dio dio = Dio();
                final response =
                    await dio.get('https://jsonplaceholder.org/users');
                if (response.statusCode == 200) {
                  print(response.data);
                } else {
                  print('Falied to fetch');
                }
              },
              child: Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final response = await get(url);

  return response.body;
}

final counterProvider =
    StateNotifierProvider<Counter, int>((ref) => (Counter()));

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() {
    state++;
  }
}

// TODO create a state notifier
// final

// TODO create class for state notifier
