import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:provider/provider.dart' as provider;

void main() {
  runApp(
    provider.ChangeNotifierProvider(create: (context) => Counter(),
    child: MyApp()));
}

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
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Text("You tapped this many times:"),
            provider.Consumer(builder: (context, counter, child) => Text(
              "${counter?.value}"),),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                var counter = context.read<Counter>();
                counter.increment();
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

                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                // Sorry, did not have time
                String result = await fetchDataWithHTTP();
                print(result);
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                print(result);
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

class Counter with ChangeNotifier {
  int value = 0;
  Counter() : super() {
    value = 0;
  }

  void increment() {
    value += 1;
    notifyListeners();
  }
}

Future<String> fetchData() async {
  final dio = Dio();
  final response = await dio.get("https://jsonplaceholder.typicode.com/posts/1");

  return "${response.statusCode} with ${response.statusMessage}.";
}

Future<String> fetchDataWithHTTP() async {
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"))

  return "${response.statusCode} with ${response.toString()}.";
}


// final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
// final 

// TODO create class for state notifier
