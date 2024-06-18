import 'dart:convert';

import 'package:education/templates/lab4/task_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

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
    final notifier = ref.watch(stateNotifierProvider);

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Task1(text: result)));
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task: $counter'),
            ),
            ElevatedButton(
              onPressed: () {
                notifier.increment();
              },
              child: Text('Riverpod Task: ${notifier.counter}'),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                if (response.statusCode == 200) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Task1(text: response.body)));
                } else {
                  print('Failed to load Data');
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final dio = Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                if (response.statusCode == 200) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Task1(text: response.data.toString())));
                } else {
                  print('Failed to load Data');
                }
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
  final link = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (link.statusCode == 200) {
    return utf8.decode(link.bodyBytes); // Преобразование Uint8List в строку
  } else {
    throw Exception('Failed to load Data');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

// Исправленный StateNotifier
class CounterNotifier extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

final stateNotifierProvider = ChangeNotifierProvider((ref) => CounterNotifier());