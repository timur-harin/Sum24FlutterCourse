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
                String result = await fetchData();
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text(ref.watch(counterProvider).toString()),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider2.notifier).increment();
              },
              child: Text(ref.watch(counterProvider2)._counter.toString()),
            ),
            ElevatedButton(
              onPressed: () async {
              final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
              final response = await http.get(url);   
              ref.read(HTTPProvider.notifier).state = response.body;
              },
              child: Text('HTTP Task'),
            ),
            Text("HTTP: " + ref.watch(HTTPProvider), style: TextStyle(fontSize: 10),),
            ElevatedButton(
              onPressed: () async {
                Dio dio = Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                ref.read(DioProvider.notifier).state = response.data.toString();// Exercise 5 - Make an HTTP request using Dio and show it in App Screen
              },
              child: Text('Dio Task'),
            ),
            Text("HTTP: " + ref.watch(DioProvider), style: TextStyle(fontSize: 10),),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.body);
  }
  return response.body;
}

final counterProvider = StateProvider<int>((ref) => 0);

final HTTPProvider = StateProvider<String>((ref) => "");

final DioProvider = StateProvider<String>((ref) => "");

final counterProvider2 = ChangeNotifierProvider( (ref) => CounterProvider());

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}


