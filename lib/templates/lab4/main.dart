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
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result),
                  ),
                );
                //ref.watch(jsonTextProvider.notifier).state = result;
              },
              child: const Text('Async/Await Task'),
            ),
            Text(ref.watch(jsonTextProvider)),
            ElevatedButton(
              onPressed: () {
                ref.watch(counterProvider.notifier).state++;
              },
              child: Text(
                  'Provider Task – counter: ${ref.watch(counterProvider)}'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.watch(counterRiverpodProvider.notifier).increment();
              },
              child: Text(
                  'Riverpod Task – counter: ${ref.watch(counterRiverpodProvider)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result),
                  ),
                );
                //ref.watch(jsonTextProvider.notifier).state = result;
              },
              child: const Text('HTTP Task'),
            ),
            Text(ref.watch(httpJsonTextProvider)),
            ElevatedButton(
              onPressed: () async {
                Response response = await Dio()
                    .get('https://jsonplaceholder.typicode.com/posts/1');
                ref.watch(dioJsonTextProvider.notifier).state =
                    response.data.toString();
              },
              child: const Text('Dio Task'),
            ),
            Text(ref.watch(dioJsonTextProvider)),
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
    return response.body;
  } else {
    throw Exception('Data Loading Exception');
  }
}

final jsonTextProvider = StateProvider<String>((ref) => '');
final httpJsonTextProvider = StateProvider<String>((ref) => '');
final dioJsonTextProvider = StateProvider<String>((ref) => '');
final counterProvider = StateProvider<int>((ref) => 0);

class CounterState extends StateNotifier<int> {
  CounterState() : super(0);

  void increment() {
    state++;
  }
}

final counterRiverpodProvider = StateNotifierProvider<CounterState, int>((ref) {
  return CounterState();
});
