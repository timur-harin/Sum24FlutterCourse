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
    return const ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String responseText = "No response received, yet";

  @override
  Widget build(BuildContext context) {
    const double widgetMargin = 8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(widgetMargin),
                  child: ElevatedButton(
                    onPressed: () async {
                      // TODO Exercise 1 - Perform an async operation using async/await
                      setState(() {
                        responseText = "Waiting for response...";
                      });
                      String result = await fetchData();
                      setState(() {
                        responseText = result;
                      });
                    },
                    child: const Text('Async/Await Task'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(widgetMargin),
                  child: ElevatedButton(
                    onPressed: () {
                      // Exercise 2 - Use Provider for state management
                      // Increment the counter
                    },
                    child: const Text('Provider Task'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(widgetMargin),
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO
                      // Exercise 3 - Use Riverpod for state management
                      // Increment the counter
                    },
                    child: const Text('Riverpod Task'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(widgetMargin),
                  child: ElevatedButton(
                    onPressed: () async {
                      // TODO
                      // Exercise 4 - Make an HTTP request using the HTTP package
                    },
                    child: const Text('HTTP Task'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(widgetMargin),
                  child: ElevatedButton(
                    onPressed: () async {
                      // TODO
                      // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                    },
                    child: const Text('Dio Task'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: widgetMargin, 
                    horizontal: widgetMargin * 3
                  ),
                  child: Text(responseText),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

Future<String> fetchData() async {
  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'

  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return response.body.toString();
  } else {
    // If the server did not return an OK response, throw an exception
    throw Exception('Failed to load data');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
// final

// TODO create class for state notifier
