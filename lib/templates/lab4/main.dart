import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

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
    final dioResponse = ref.watch(dioProvider);
    int riverpodCounter = ref.watch(riverpodCounterProvider);

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
                showDialog(context: context, builder: (context) => AlertDialog(
                  content: Text(result),
                ));
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
                // Exercise 2 - Use Provider for state management
                // Increment the counter
              },
              child: Text('Provider Task'),
            ),
            SizedBox(height: 20),
            Text(
              'Counter Value: $counter',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(riverpodCounterProvider.notifier).increment();
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
              },
              child: Text('Riverpod Task'),
            ),
            SizedBox(height: 20),
            Text(
              'Counter Value: $riverpodCounter',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchHttpData();
                showDialog(context: context, builder: (context) => AlertDialog(
                  content: Text(result)
                ));

                // Exercise 4 - Make an HTTP request using the HTTP package
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                ref.refresh(dioProvider);
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
              },
              child: Text('Dio Task'),
            ),
            dioResponse.when(
              data: (data) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("This is Dio task: $data"),
              ),
              loading: () => CircularProgressIndicator(),
              error: (err, stack) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Error: $err'),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return json.decode(response.body)['title'];
  } else {
    throw Exception('Failed to load data');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

final riverpodCounterProvider =
    StateNotifierProvider<RiverpodCounterNotifier, int>((ref) => RiverpodCounterNotifier());

  

class RiverpodCounterNotifier extends StateNotifier<int> {
  RiverpodCounterNotifier() : super(0);

  void increment() {
    state++;
  }
}

final dioProvider = FutureProvider<String>((ref) async {
  final response =
      await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
  if (response.statusCode == 200) {
    return response.data['title'];
  } else {
    throw Exception('Failed to load data');
  }
});


Future<String> fetchHttpData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return json.decode(response.body)['title'];
  } else {
    throw Exception('Failed to load data');
  }
}
