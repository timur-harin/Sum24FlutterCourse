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

<<<<<<< HEAD
<<<<<<< HEAD
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
=======
class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
>>>>>>> 260b2ab (lab 4)
=======
class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
>>>>>>> 260b2ab (lab 4)
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
<<<<<<< HEAD
<<<<<<< HEAD
                // TODO
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
=======
=======
>>>>>>> 260b2ab (lab 4)
                String result = await fetchData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result),
                  ),
                );
<<<<<<< HEAD
>>>>>>> 260b2ab (lab 4)
=======
>>>>>>> 260b2ab (lab 4)
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> 260b2ab (lab 4)
                ref.read(counterProvider.notifier).state++;
                int result = ref.watch(counterProvider);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result.toString()),
                  ),
                );
<<<<<<< HEAD
>>>>>>> 260b2ab (lab 4)
=======
>>>>>>> 260b2ab (lab 4)
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
<<<<<<< HEAD
<<<<<<< HEAD
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
=======
=======
>>>>>>> 260b2ab (lab 4)
                ref.read(riverpodCounterProvider.notifier).increment();
                int result = ref.watch(riverpodCounterProvider);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result.toString()),
                  ),
                );
<<<<<<< HEAD
>>>>>>> 260b2ab (lab 4)
=======
>>>>>>> 260b2ab (lab 4)
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
<<<<<<< HEAD
<<<<<<< HEAD
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
=======
=======
>>>>>>> 260b2ab (lab 4)
                String result = await fetchHttpData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result),
                  ),
                );
                print(result);
<<<<<<< HEAD
>>>>>>> 260b2ab (lab 4)
=======
>>>>>>> 260b2ab (lab 4)
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
<<<<<<< HEAD
<<<<<<< HEAD
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
=======
=======
>>>>>>> 260b2ab (lab 4)
                String result = await fetchDioData();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(result),
                  ),
                );
<<<<<<< HEAD
>>>>>>> 260b2ab (lab 4)
=======
>>>>>>> 260b2ab (lab 4)
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
<<<<<<< HEAD
<<<<<<< HEAD
  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'

  return 'data';
=======
=======
>>>>>>> 260b2ab (lab 4)
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> fetchHttpData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> fetchDioData() async {
  try {
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data.toString();
  } catch (e) {
    throw Exception('Failed to load data');
  }
<<<<<<< HEAD
>>>>>>> 260b2ab (lab 4)
=======
>>>>>>> 260b2ab (lab 4)
}

final counterProvider = StateProvider<int>((ref) => 0);

<<<<<<< HEAD
<<<<<<< HEAD
// TODO create a state notifier
// final 

// TODO create class for state notifier
=======
=======
>>>>>>> 260b2ab (lab 4)
final riverpodCounterProvider =
    StateNotifierProvider<RiverpodCounter, int>((ref) => RiverpodCounter());

class RiverpodCounter extends StateNotifier<int> {
  RiverpodCounter() : super(0);

  void increment() {
    state++;
  }
}
<<<<<<< HEAD
>>>>>>> 260b2ab (lab 4)
=======
>>>>>>> 260b2ab (lab 4)
