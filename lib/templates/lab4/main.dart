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
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Provider Task'),
            ),
            CounterDisplay(),
            ElevatedButton(
              onPressed: () async {
                var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
                var response = await http.get(url);
                if (response.statusCode == 200) {
                  print(response.body);
                } else {
                  print("Failed: ${response.statusCode}");
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
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
  // 'https://jsonplaceholder.typicode.com/posts/1'
  Dio dio = Dio();
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  var response = await dio.get(url.toString());
  if (response.statusCode == 200) {
    return response.data;
  } else {
    print("Request failed (code ${response.statusCode})");
  }
  return 'data';
}

final counterProvider = StateProvider<int>((ref) => 0);

// Task 3
class CounterDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var counterValue = ref.watch(counterProvider);
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => ref.read(counterProvider.notifier).state++,
          child: Text('Riverpod Task'),
        ),
        Text("$counterValue")
      ],
    );
  }
}
