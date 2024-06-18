import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart' as provider;


void main() {
  runApp (MultiProvider(providers: [
    provider.Provider(create: (_) => CounterStateNotifier()),
  ], 
  child: MyApp()));
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
    final counterProviderNext =
        provider.Provider.of<CounterStateNotifier>(context, listen: true);
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
               counterProviderNext.increment();
               print(counterProviderNext.count);
                
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterStateNotifierProvider.notifier).increment();
                print(ref.read(counterProvider));
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
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
                var dio = Dio();
                var url = 'https://jsonplaceholder.typicode.com/posts/1';
                var response = await dio.get(url);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Dio Response'),
                      content: Text(response.data.toString()),
                      actions: <Widget>[
                        TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              print(response.toString());
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
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "Error";
  }
}

final counterProvider = StateProvider<int>((ref) => 0);


class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);

int _count = 0;

int get count => _count;

  void increment() {
    _count++;
    state = _count;

  }
}

final counterStateNotifierProvider = StateNotifierProvider<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier();
});