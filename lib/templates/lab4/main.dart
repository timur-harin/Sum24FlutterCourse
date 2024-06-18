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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter with Provider ${ref.watch(counterProvider)}',
            ),
            Text(
              'Counter with Riverpod ${ref.watch(counterRiverpodProvider)}',
            ),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                _dialogBuilder(context, result);
                //print(result);
              },
              child: const Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: const Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterRiverpodProvider.notifier).increment();
              },
              child: const Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                _dialogBuilder(context, result);
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                Response response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
                _dialogBuilder(context, response.data.toString());
              },
              child: const Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, String result) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Task Complete'),
          content: Text(result),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<String> fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return 'Error: ${response.statusCode}';
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class CounterState extends StateNotifier<int> {
  CounterState() : super(0);
  void increment() => state++;
}

final counterRiverpodProvider = StateNotifierProvider<CounterState, int>(
  (ref) => CounterState(),
);
