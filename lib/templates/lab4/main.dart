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
  Dio dio = Dio();
  
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
                // TODO
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                 ref.read(httpDataProvider.notifier).state = result;
              },
              child: Text('Async/Await Task'),
            ),
          
           Text(ref.watch(httpDataProvider)),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task. Counter: ${ref.watch(counterProvider)}'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: Text('Riverpod Task. Counter: ${ref.watch(counterNotifierProvider)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

                if (response.statusCode == 200) {
                  ref.read(httpDataProvider.notifier).state = response.body;
                } else {
                  print('Data Loading Exception');
                }
              },
              child: Text('HTTP Task'),
            ),
            Text(ref.watch(httpDataProvider)),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');

                if (response.statusCode == 200) {
                // Request was successful
                ref.read(dioDatatProvider.notifier).state = response.data.toString();

                // Do something with the data
                } else {
                  // Request failed
                  print('Request failed with status: ${response.statusCode}');
                }
              },
              child: Text('Dio Task'),
            ),
            Text(ref.watch(dioDatatProvider))
          ],
        ),
      ),
    );
  }
}


Future<String> fetchData() async {
  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Data Loading Exception');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);
final httpDataProvider = StateProvider<String>((ref) => '');
final dioDatatProvider = StateProvider<String>((ref) => '');
final statusProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
// final 
final counterNotifierProvider = StateNotifierProvider<CounterState, int>((ref){
  return CounterState();
});


// TODO create class for state notifier
class CounterState extends StateNotifier<int> {
  CounterState() : super(0);

  void increment() {
    state++;
  }
}