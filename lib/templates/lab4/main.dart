import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'Screen.dart';

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
                String text = await fetchData();
                ref.read(json.notifier).state = text;    
              },
              child: const Text('Async/Await Task'),
            ),
            Text(ref.watch(json)),
            ElevatedButton(
              // Oh, it's easy...
              onPressed: () {
                ref.read(counter.notifier).state++;
              },
              child: Text('Provider Task = ${ref.watch(counter)}'),
            ),
            ElevatedButton(
              onPressed: () {
                // And this too...
                ref.read(counterWithRiverPod.notifier).incrementNumber();
              },
              child: Text('Riverpod Task = ${ref.watch(counterWithRiverPod)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                //Like this?
                ref.read(httpProvider.notifier).state = await fetchData();
              },
              child: const Text('HTTP Task'),
            ),
              Text(ref.watch(httpProvider)),
            ElevatedButton(
              onPressed: () async {
                Response text = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
                ref.read(dio.notifier).state = text.toString();  
              },
              child: const Text('Dio Task'),
            ),
            Text(ref.watch(dio)),
            Image.network('data:image/jpeg;base64,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',
              width: 200,
              height: 200
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

final counterProvider = StateProvider<int>((ref) => 0);
final counter = StateProvider<int>((ref) => 0);
final json = StateProvider<String>((ref) => '');
final dio = StateProvider<String>((ref) => '');
final httpProvider = StateProvider<String>((ref) => '');
 
class CounterForState extends StateNotifier<int> {
  CounterForState() : super(0);


  void incrementNumber() {
    state++;
  }
}

final counterWithRiverPod = StateNotifierProvider<CounterForState, int>((ref) {
  return CounterForState();
});