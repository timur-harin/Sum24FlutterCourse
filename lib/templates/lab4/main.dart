import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

// CounterNotifier class


void main() {
  runApp(
    MultiProvider(providers: [
    Provider (create: (_) => CounterNotifierRiverpod(),),
    ],
    child: MyApp(),
    )
    );}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return riverpod.ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends riverpod.ConsumerWidget {
  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    final counterNotifier = Provider.of<CounterNotifierRiverpod>(context, listen: true);

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
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                counterNotifier.increment();
                print('Counter: ${counterNotifier.cntr}');
              },
              child: Text('Provider Task (Counter: ${counterNotifier.cntr})'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterProviderThroghRiverpod.notifier).increment();
                print('Counter: ${ref.read(counterProviderThroghRiverpod)}');

              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    print( response.body);
  }
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                  final url = 'https://jsonplaceholder.typicode.com/posts/1';

  final response = await Dio().get(url);
  //make showDialog which show the response
  if (response.statusCode == 200) {

  showDialog(context: context, builder: 
    (context) => AlertDialog(
    content: Text(response.toString()),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
    ],
    )
  );
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


// TODO create a state notifier
final counterProviderThroghRiverpod =
  riverpod.StateNotifierProvider<CounterNotifierRiverpod, int>((ref) {
  return CounterNotifierRiverpod();
});

// TODO create class for state notifier
class CounterNotifierRiverpod extends riverpod.StateNotifier<int> {
  CounterNotifierRiverpod() : super(0);

  int _cntr = 0;
  int get cntr => _cntr;

  void increment() {
    _cntr++;
    state = _cntr;
  }
}

Future<String> fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  }
  return 'data';
}
