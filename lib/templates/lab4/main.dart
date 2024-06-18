import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    final dio = Dio();
    int counter = ref.watch(counterProvider);
    CounterModel counter2 = ref.watch(counterProvider2);

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
              child: Text('Provider Task: $counter'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterProvider2.notifier).increment();
              },
              child: Text('Riverpod Task: ' + counter2.value.toString()),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 4 - Make an HTTP request using the HTTP package
                print(await http.get(
                    Uri.parse('https://jsonplaceholder.typicode.com/posts/1')));
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final response = await dio
                    .get('https://jsonplaceholder.typicode.com/posts/1');
                final res = response.toString();
                print(res);
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
  // 'https://jsonplaceholder.typicode.com/posts/1'
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  return response.body;
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
class CounterProvider extends StateNotifier<CounterModel> {
  CounterProvider() : super(CounterModel(value: 0));

  void increment() {
    state = CounterModel(value: state.value! + 1);
  }
}

final counterProvider2 = StateNotifierProvider<CounterProvider, CounterModel>((ref) {
  return CounterProvider();
});

// TODO create class for state notifier
class CounterModel {
  CounterModel({
    this.value
  });

  int? value;
}