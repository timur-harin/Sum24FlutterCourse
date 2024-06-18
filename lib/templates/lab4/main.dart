import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(ProviderScope(child:MyApp()));
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
    final counter1 = ref.watch(counterProvider);
    final counter2 = ref.watch(counterStateNotifierProvider);
    final task5 = ref.watch(requestProvider);
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
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterStateNotifierProvider.notifier).increment();
              },
              child: Text('Riverpod Task'),
            ),
            
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
                http.get(url).then((value) {
                  if (value.statusCode == 200) {
                    final json = jsonDecode(value.body);
                    print("Request received successfully: ${json}");
                  } else {
                  throw Exception('Failed to load data');
                  }
                });
                
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final dio = await Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                if (response.statusCode == 200) {
                  final json = await (response.data);
                  ref.read(requestProvider.notifier).state = json.toString();
                } else {
                  ref.read(requestProvider.notifier).state = "Failed to load data";
                }
              },
              child: Text('Dio Task'),
            ),
            Text("Counter fron Provider: ${counter1}"),
            Text("Counter fron StateNotifierProvider: ${counter2}"),
            Text("Request for fifth task:'${task5}'")
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  // TODO get json from url and show as text
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return json.toString();
  } else {
    throw Exception('Failed to load data');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

final requestProvider = StateProvider<String>((ref) => "");

// TODO create a state notifier
final counterStateNotifierProvider = StateNotifierProvider<CounterStateNotifier, int>((ref) => CounterStateNotifier());


// TODO create class for state notifier
class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);

  void increment() {
    state++;
  }
}
