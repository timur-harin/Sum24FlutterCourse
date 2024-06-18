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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Todo'),
                    content: Text(result),
                  ),
                );
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Make an HTTP request using the HTTP package
                // and print the response
                http.Response response = await http.get(
                  Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
                );
                final todo = response.body;
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Todo'),
                    content: Text(todo),
                  ),
                );
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await Dio().get('https://jsonplaceholder.typicode.com/todos/1');
                final todo = response.data.toString();
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Todo'),
                    content: Text(todo),
                  ),
                );
                
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
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  }
  return 'No data D:';
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
// final 

// TODO create class for state notifier
