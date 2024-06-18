import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';

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
    var text = const Text("for results");
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
                ref.read(jsonProvider.notifier).state = result;

              },
              child: Text('text: ${ref.watch(jsonProvider)}'),
            ), 
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state += 1;
              },
              child: Text('Provider Task ${ref.watch(counterProvider)}'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterRiverpodProvider.notifier).increment();

              },
              child: Text('Riverpod Task, count: ${ref.watch(counterRiverpodProvider)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                ref.read(httpProvider.notifier).state = await fetchData();

              },
              child: Text('HTTP Task'),
            ),
            Text('${ref.watch(httpProvider)}'),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final response = await Dio().get("https://jsonplaceholder.typicode.com/posts/1");
                ref.read(dioProvider.notifier).state = response.toString();
              },
              child: Text('Dio Task'),
            ),
            Text(
              ref.watch(dioProvider)
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");
  final response = await get(url);
  
  if (response.statusCode == 200) {
    return response.body;
  }
  else {
    return 'Request failed with status: ${response.statusCode}.';
  }
}

// default Providers
final jsonProvider = StateProvider<String>((ref) => '');
final counterProvider = StateProvider<int>((ref) => 0);
final httpProvider = StateProvider<String>((ref) => '');
final dioProvider = StateProvider<String>((ref) => '');

// riverpod Providers
class CounterRiverpodState extends StateNotifier<int> {
  CounterRiverpodState() : super(0);

  void increment() {
    state++;
  }
}

final counterRiverpodProvider = StateNotifierProvider<CounterRiverpodState, int>((ref) {
  return CounterRiverpodState();
});