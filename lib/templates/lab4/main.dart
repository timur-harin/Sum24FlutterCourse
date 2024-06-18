import 'dart:js_interop';

import 'package:flutter/foundation.dart';
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
  final counterProvider = StateProvider<int>((ref) => 0);

  get ref => null;

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
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result),
                  ),
                  // builder: (context) => AlertDialog( ПОКАЗ КОШКИ НЕ ЗНАЮ ЗАЧЕМ И ПОЧЕМУ НО ОН ЕСТЬ
                  //   content: Image.network("https://img.freepik.com/free-photo/close-up-beautiful-cat_23-2149216316.jpg?t=st=1718738005~exp=1718741605~hmac=1993aa6cb82a7ee41b6e4ddf36e8b8802b8cd31ba90fd4ebea3866cca5e0df0f&w=2000"),
                  // ),
                );
              },
              child: const Text('Async/Await Task'),
            ),

            ElevatedButton(
              onPressed: () {
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
                String result = await fetchData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result),
                  ),
                );
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                // 'https://jsonplaceholder.typicode.com/posts/1'
                Dio dio = Dio();
                const url = 'https://jsonplaceholder.typicode.com/posts/1';
                final response = await dio.get(url);

                if (response.statusCode == 200) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(response.data.toString()),
                    ),
                  );
                } else {
                  throw Exception('Failed to load data');
                }
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
  // 'https://jsonplaceholder.typicode.com/posts/1'
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier

final counterStateNotifierProvider = StateNotifierProvider<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier();
});

// TODO create class for state notifier

class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}
