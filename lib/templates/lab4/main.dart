import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:provider/provider.dart' hide ChangeNotifierProvider;


void main() {
  runApp(
    const MyApp());
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

    //Does not work provider, idk why
    // final counterProvider = Provider.of<Counter>(context, listen: false);

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
                String response = await fetchData();
                ref.read(resultFROMJSON.notifier).state = response;
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management

                // Increment the counter
                // Provider does not work, idk why
                // counterProvider.increment();
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterRiverpod.notifier).increment();
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                ref.read(resultFROMJSON.notifier).state = response.body;
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final dio = Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                ref.read(resultFROMJSON.notifier).state = response.data.toString();
              },
              child: Text('Dio Task'),
            ),
            Text("Riverpod Counter: ${ref.watch(counterRiverpod)}"),
            Text("Result from JSON: ${ref.watch(resultFROMJSON)}"),
            // Text("Provider counter: ${counterProvider.counter}"),
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

final counterRiverpod = StateNotifierProvider<CounterNotifier,int>((ref) => CounterNotifier());

// TODO create a state notifier
// final 

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  int _counter = 0;

  void increment() {
    _counter++;
    state = _counter;
  }

  int get counter => _counter;  
  set counter(int value) => _counter = value;
}

final resultFROMJSON = StateNotifierProvider<resultFROMJSONNotifier, String>((ref) => resultFROMJSONNotifier());


class resultFROMJSONNotifier extends StateNotifier<String> {
  resultFROMJSONNotifier() : super('');

  String _result = '';

  String get result => _result;
  set result(String value) => _result = value;
}

// Does not work, idk why
// class Counter extends ChangeNotifier{
//   int _counter = 0;

//   void increment() {
//     _counter++;
//     notifyListeners();
//   }

//   int get counter => _counter;  
//   set counter(int value) => _counter = value;
// }

