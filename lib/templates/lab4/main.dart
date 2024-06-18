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
                ref.read(jsonTextProvider.notifier).state = result;
              },
              child: const Text('Async/Await'),
            ),
            Text(ref.watch(jsonTextProvider)),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text(
                  'Provider counter: ${ref.watch(counterProvider)}'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterRiverpodProvider.notifier).increment();
              },
              child: Text(
                  'Riverpod counter: ${ref.watch(counterRiverpodProvider)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                ref.read(httpJsonTextProvider.notifier).state = result;
              },
              child: const Text('HTTP'),
            ),
            Text(ref.watch(httpJsonTextProvider)),
            ElevatedButton(
              onPressed: () async {
                Response response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
                ref.read(dioJsonTextProvider.notifier).state = response.data.toString();
              },
              child: const Text('Dio'),
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



final counterRiverpodProvider = StateNotifierProvider<CounterState, int>((ref) {
  return CounterState();
});
class CounterState extends StateNotifier<int> {
  CounterState() : super(0);

  void increment() {
    state++;
  }
}
