import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
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
  const MyHomePage({super.key});

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
                String result = await fetchData();
                print(result);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Alert!!!'),
                        content: Text(result),
                      );
                    });
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.watch(counterProvider.notifier).state++;
              },
              child:
                  Text('Provider Task, counter: ${ref.watch(counterProvider)}'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.watch(counterProviderRP.notifier).add(1);
              },
              child: Text(
                  'Riverpod Task, counter: ${ref.watch(counterProviderRP)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                final url =
                    Uri.parse('https://jsonplaceholder.typicode.com/posts/11');

                final response = await http.get(url);

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Alert!!!'),
                        content: Text(response.body.toString()),
                      );
                    });
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final url =
                    Uri.parse('https://jsonplaceholder.typicode.com/posts/8');
                final response = await Dio().get(url.toString());
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Alert!!!'),
                        content: Text(response.data.toString()),
                      );
                    });
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
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return 'Request failed with status: ${response.statusCode}.';
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class CounterState extends StateNotifier<int> {
  CounterState(super.state);
  void add(int value) {
    state += value;
  }
}

final counterProviderRP =
    StateNotifierProvider<CounterState, int>((ref) => CounterState(0));