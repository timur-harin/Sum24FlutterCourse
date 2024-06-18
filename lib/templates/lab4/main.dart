import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/http.dart' as http;
import 'package:flutter/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                String result = await fetchData();
                print(result);
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
                // TODO
                // Exercise 4 - Make an HTTP request using the HTTP package
                String result = await fetchData();
                print(result);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Scaffold(
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('$result'),
                              ElevatedButton(
                                onPressed:(){
                                  Navigator.of(context).pop();
                                },
                                child: Text('close'),
                              )
                            ],
                          )
                      );
                    }
                );
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                String result = await fetchDioData();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Scaffold(
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('$result'),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              )
                            ],
                          )
                      );
                    }
                );
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
  final response = await http.get(url.toString());
  if (response.statusCode == 200) {
    return response.data.toString();
  } else {
    return ('Request failed with status: ${response.statusCode}.');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void Increment() {
    state++;
  }
}

final notifier = Counter();

final Provider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

Future<String> fetchDioData() async {
  try {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await dio.get(url.toString());
    return response.data.toString();
  } catch (e) {
    return 'Request failed.';
  }
}
