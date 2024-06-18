import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter: $counter'),
            ElevatedButton(
              onPressed: () async {
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                print(result);
              },
              child: const Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state++;
              },
              child: const Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: const Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                if (response.statusCode == 200) {
                  final data = jsonDecode(response.body);
                  print(data);
                } else {
                  print('Failed to load data');
                }
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                await dioRequest();
              },
              child: const Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  // TODO get json from url and show as text
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['title'];
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> dioRequest() async {
  final dio = Dio();
  try {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    print(response.data);
  } catch (e) {
    print('Failed to load data: $e');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
