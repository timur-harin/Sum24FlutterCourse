import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Flutter Tasks'),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           ElevatedButton(
  //             onPressed: () async {
  //               String result = await fetchData();
  //               print(result);
  //             },
  //             child: const Text('Async/Await Task'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               // Exercise 2 - Use Provider for state management
  //               // Increment the counter
  //             },
  //             child: const Text('Provider Task'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               // TODO
  //               // Exercise 3 - Use Riverpod for state management
  //               // Increment the counter
  //             },
  //             child: const Text('Riverpod Task'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               // TODO
  //               // Exercise 4 - Make an HTTP request using the HTTP package
  //             },
  //             child: const Text('HTTP Task'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               // TODO
  //               // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
  //             },
  //             child: const Text('Dio Task'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

final resultProvider = StateNotifierProvider<ResultNotifier, String>((ref) {
  return ResultNotifier();
});

class ResultNotifier extends StateNotifier<String> {
  ResultNotifier() : super('Placeholder for answer');

  void updateResult(String newResult) {
    state = newResult;
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  int counter = 0;

  void increment() {
    counter++;
    state = counter;
  }
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                ref.read(resultProvider.notifier).updateResult('Task 1: $result');
              },
              child: const Text('Async/Await Task1'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).increment();
                ref.read(resultProvider.notifier).updateResult('Task 2: ${ref.read(counterProvider)}');
              },
              child: const Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).increment();
                ref.read(resultProvider.notifier).updateResult('Task 3: ${ref.read(counterProvider)}');
              },
              child: const Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                var url = 'https://jsonplaceholder.typicode.com/posts/1';
                var response = await http.get(Uri.parse(url));
                var data = jsonDecode(response.body);
                ref.read(resultProvider.notifier).updateResult('Task 4: ${data.toString()}');
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                Dio dio = Dio();
                final url =
                    Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
                final response = await dio.get(url.toString());

                late String answer;
                if (response.statusCode == 200) {
                  answer = response.data.toString();
                } else {
                  answer = 'Request failed with status: ${response.statusCode}.';
                }
                ref.read(resultProvider.notifier).updateResult('Task 5: $answer');
              },
              child: const Text('Dio Task'),
            ),
            Consumer(
              builder: (context, watch, child) {
                final result = ref.watch(resultProvider);
                return Text(result);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    var url = 'https://jsonplaceholder.typicode.com/posts/1';
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    return data.toString();
  }
}