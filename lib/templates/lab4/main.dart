import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider(create: (_) => Counter()),
  ],
  child: MyApp()));
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
    final counterProvider2 = Provider.of<Counter>(context, listen: true);

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
                // Container(
                //   child: Text(result),
                // );
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                counterProvider2.increment();
                print(counterProvider2._counter);
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterProvider.notifier).increment();
                print(ref.read(counterProvider));
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                if (response.statusCode == 200) {
                  print(response.body);
                } else {
                  throw Exception('Failed to load data');
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
                print(response.toString());

                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(response.toString()),
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

final counterProvider = StateNotifierProvider<Counter, int>((ref) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  int _counter = 0;

  void increment() {
    _counter++;
    state = _counter;
  } 

  int get counter => _counter;

  set counter(int value) => _counter = value;
}

class Counter2 extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}