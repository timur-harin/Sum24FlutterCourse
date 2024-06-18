import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends ConsumerWidget {
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
                String fetchedData = await fetchData();
                ref.read(jsonState.notifier).state = fetchedData;
              },
              child: Text('Async/Await Task'),
            ),
            Text(ref.watch(jsonState)),
            ElevatedButton(
              onPressed: () => ref.read(counterState.notifier).state++,
              child: Text('Provider Task = ${ref.watch(counterState)}'),
            ),
            ElevatedButton(
              onPressed: () => ref.read(riverpodCounterState.notifier).incrementCounter(),
              child: Text('Riverpod Task = ${ref.watch(riverpodCounterState)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                String httpResponse = await fetchData();
                ref.read(httpResponseState.notifier).state = httpResponse;
              },
              child: Text('HTTP Task'),
            ),
            Text(ref.watch(httpResponseState)),
            ElevatedButton(
              onPressed: () async {
                Response dioResponse = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
                ref.read(dioResponseState.notifier).state = dioResponse.toString();
              },
              child: Text('Dio Task'),
            ),
            Text(ref.watch(dioResponseState)),
            Image.network(
              'https://ref.watch/dio',
              width: 400,
              height: 400
            ),
          ],
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final jsonState = StateProvider<String>((ref) => '');
final counterState = StateProvider<int>((ref) => 0);
final dioResponseState = StateProvider<String>((ref) => '');
final httpResponseState = StateProvider<String>((ref) => '');
final riverpodCounterState = StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void incrementCounter() {
    state++;
  }
}
