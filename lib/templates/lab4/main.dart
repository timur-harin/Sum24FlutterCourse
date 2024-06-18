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
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result),
                  ),
                );
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                ref.read(counterProvider.notifier).state++;
              },
              child: Consumer(
                builder: (context, watch, _) {
                  final counter = ref.watch(counterProvider);
                  return Text('Provider Task: $counter');
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 3 - Use Riverpod for state management
                ref.read(counterStateNotifierProvider.notifier).increment();
              },
              child: Consumer(
                builder: (context, watch, _) {
                  final counter = ref.watch(counterStateNotifierProvider);
                  return Text('Riverpod Task: $counter');
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 4 - Make an HTTP request using the HTTP package
                String data = await fetchData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(data),
                  ),
                );
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                var data = await fetchDioData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(data),
                  ),
                );
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
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> fetchDioData() async {
  final dio = Dio();
  final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    return response.data.toString();
  } else {
    throw Exception('Failed to load data');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

final counterStateNotifierProvider = StateNotifierProvider<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier();
});

class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}
