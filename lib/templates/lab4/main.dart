import 'dart:typed_data';

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

final riverpodCounterProvider = StateProvider<int>((ref) => 0);

class MyHomePage extends ConsumerWidget  {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riverpodCounter = ref.watch(riverpodCounterProvider);
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
                // TODO
                // Exercise 1 - Perform an async operation using async/await
                String result = await performAsyncTask();
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
                // Increment the counter
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: Text('Provider Task'),
            ),
            Text(
              'Counter: ${counterNotifier}',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(riverpodCounterProvider.notifier).state++;
              },
              child: Text('Riverpod Task'),
            ),
            Text(
              'Counter: ${riverpodCounter}',
              style: TextStyle(fontSize: 20),
            ),
            
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                String response = await fetchData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(response),
                  ),
                );
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                String response = await fetchDioData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(response),
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

Future<String> performAsyncTask() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Async operation completed';
}

Future<String> fetchData() async {
  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  }
  else{
    return "failed";
  }
}

Future<String> fetchDioData() async {
  final dio = Dio();
  try {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data.toString();
  } catch (e) {
    return 'Failed to load data';
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
// final 

// TODO create class for state notifier


class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});