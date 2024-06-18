import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider(create: (_) => CounterNotifier()),
  ], child: MyApp()));
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
    final counterProviderEx2 =
        Provider.of<CounterNotifier>(context, listen: true);

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
                counterProviderEx2.increment();
                print(counterProviderEx2.counter);
                // Exercise 2 - Use Provider for state management
                // Increment the counter
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterStateNotifierProvider.notifier).increment();
                print(ref.read(counterStateNotifierProvider));
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final url = 
                    Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
                final response = await http.get(url);
                if (response.statusCode == 200) {
                  print(response.body);
                } else {
                  print("error");
                }
                // TODO
                // Exercise 4 - Make an HTTP request using the HTTP package
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                 final String url = 'https://jsonplaceholder.typicode.com/posts/1';
                final response = await Dio().get(url);
                if (response.statusCode == 200) {
                showDialog(context: context, builder: 
                  (context) => AlertDialog(title: Text("Response dio"), content: Text(response.toString())));
                } else {
                  print("error");
                }

                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
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
  // TODO get json from url and show as text
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  }
  return 'error';
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
final counterStateNotifierProvider =
    StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

// TODO create class for state notifier
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    state = _counter;
  }
}
