import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
=======
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
>>>>>>> main
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
<<<<<<< HEAD
  const MyHomePage({super.key});

=======
>>>>>>> main
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text('Flutter Tasks'),
=======
        title: Text('Flutter Tasks'),
>>>>>>> main
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
<<<<<<< HEAD
              child: const Text('Async/Await Task'),
=======
              child: Text('Async/Await Task'),
>>>>>>> main
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
              },
<<<<<<< HEAD
              child: const Text('Provider Task'),
=======
              child: Text('Provider Task'),
>>>>>>> main
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
              },
<<<<<<< HEAD
              child: const Text('Riverpod Task'),
=======
              child: Text('Riverpod Task'),
>>>>>>> main
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
              },
<<<<<<< HEAD
              child: const Text('HTTP Task'),
=======
              child: Text('HTTP Task'),
>>>>>>> main
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
              },
<<<<<<< HEAD
              child: const Text('Dio Task'),
=======
              child: Text('Dio Task'),
>>>>>>> main
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'

  return 'data';
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
// final 

// TODO create class for state notifier
