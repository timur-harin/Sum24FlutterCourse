import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

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
    final counter = ref.watch(counterProvider);
    final counterNotifier = ref.watch(counterNotifierProvider);

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
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task ($counter)'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: Text('Riverpod Task ($counterNotifier)'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 4 - Make an HTTP request using the HTTP package
                String result = await fetchHttpData();
                print(result);
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                String result = await fetchDioData();
                print(result);
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
  // Get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> fetchHttpData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> fetchDioData() async {
  Dio dio = Dio();
  final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
  return response.data.toString();
}

final counterProvider = StateProvider<int>((ref) => 0);

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}
