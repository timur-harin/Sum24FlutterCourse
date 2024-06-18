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

class MyHomePage extends ConsumerStatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  String _displayedData = '';

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider);

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

                setState(() {
                  _displayedData = result;
                });
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task, count: $count'),
            ),
            Consumer(
              builder: (context, ref, child) {
                final counterNotifier = ref.watch(counterNotifierProvider);
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Exercise 3 - Use ChangeNotifier for state management
                        ref.read(counterNotifierProvider.notifier).increment();
                      },
                      child: Text('Riverpod Task, count: ${counterNotifier.counter}'),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await http.get(
                    Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                if (response.statusCode == 200) {
                  setState(() {
                    _displayedData = response.body;
                  });
                } else {
                  throw Exception('Failed to load data');
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 5 - Make an HTTP request using the Dio package
                final dio = Dio();
                final response = await dio
                    .get('https://jsonplaceholder.typicode.com/posts/1');
                if (response.statusCode == 200) {
                  setState(() {
                    _displayedData = response.data.toString();
                  });
                } else {
                  throw Exception('Failed to load data');
                }
              },
              child: Text('Dio Task'),
            ),
            Text(_displayedData),
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
    throw Exception('Failed to load data');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class CounterNotifier with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

final counterNotifierProvider =
    ChangeNotifierProvider<CounterNotifier>((ref) => CounterNotifier());
