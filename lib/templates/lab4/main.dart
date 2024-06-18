import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:provider/provider.dart' hide ChangeNotifierProvider;

void main() {
  runApp(MultiProvider(providers: [
    Provider(create: (_) => Counter()),
  ], child: MyApp()));
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
    final counterProvider2 = Provider.of<Counter>(context, listen: true);
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
                onPressed: () {
                  counterProvider2.change();
                  print(counterProvider2._counter);
                },
                child: Text('Provider Task ${counterProvider2._counter}')),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter

                ref.watch(counterProvider).change();
              },
              child:
                  Text('Riverpod Task ${ref.watch(counterProvider)._counter}'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 4 - Make an HTTP request using the HTTP package
                final response = await http
                    .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                if (response.statusCode == 200) {
                  print(response.body);
                } else {
                  throw Exception('Failed to load data');
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen


                final dio = Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                if (response.statusCode == 200) {
                  print(response.data);
                  String data1 = response.data.toString();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(data1)
                      )
                    );
                } else {
                  throw Exception('Failed to load data');
                }
              },
              child: Text('Dio Task '),
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

  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }

  return 'data';
}

final counterProvider = ChangeNotifierProvider<Counter2>((ref) {
  return Counter2();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  int _counter = 0;

  void change() {
    _counter++;
    state = _counter;
  }

  int get counter => _counter;
}



 
// TODO create a state notifier
// final

// TODO create class for state notifier

class Counter2 extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void change() {
    _counter++;
    notifyListeners();
  }
}
