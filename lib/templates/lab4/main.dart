import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
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


Future<String> fetchData() async {
  // TODO get json from url and show as text
  // 
  Dio dio = Dio();
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final response = await dio.get(url.toString());
  return response.data;
}

final counterProvider = StateNotifierProvider<PlusNotifier, int>((ref) {return PlusNotifier(0);});

// TODO create a state notifier
// final 

// TODO create class for state notifier
class PlusNotifier extends StateNotifier<int> {
  PlusNotifier(this.number) : super(0);
  int number;
  int get _number => number;
  void increment() {
    number++;
    state = number;
  }
  set _number(int value) => number = value;
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // TODO
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
                final counter = Provider.of<int>(context, listen:false);
                Provider.of<int>(context, listen: false).value++;
                print("Provider Counter: ${counter}");
              },
              child: const Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                final counter = ref.watch(counterProvider);
                ref.read(counterProvider.notifier).increment();
                print("Counter: $counter");
              },
              child: const Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                if (response.statusCode == 200) {
                  print(response.body);
                } else {
                  print('FAIL: ${response.statusCode}');
                }
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
                Text("Response Data: ${response.data}");
              },
              child: const Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }
}