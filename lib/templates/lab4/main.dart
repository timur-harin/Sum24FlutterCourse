import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart' as dartpv;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const riverpod.ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyModel with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  set count(int value) {
    _count = value;
    notifyListeners();
  }
}

class MyHomePage extends riverpod.ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                print(result);
              },
              child: const Text('Async/Await Task'),
            ),
            dartpv.ChangeNotifierProvider<MyModel>(
              create: (context) => MyModel(),
              builder: (context, _) => ElevatedButton(
                onPressed: () {
                  // Exercise 2 - Use Provider for state management
                  // Increment the counter
                  final counter = dartpv.Provider.of<MyModel>(
                    context,
                    listen: false,
                  );
                  counter.count += 1;
                },
                child: Text(
                    'Provider Task, count: ${dartpv.Provider.of<MyModel>(context).count}'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state += 1;
              },
              child:
                  Text('Riverpod Task, count: ${ref.watch(counterProvider)}'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 4 - Make an HTTP request using the HTTP package
                final data = await fetchData();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(data),
                ));
              },
              child: const Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                final Response<Uint8List> image = await Dio().get(
                    'https://http.cat/images/418.jpg',
                    options: Options(responseType: ResponseType.bytes));
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('I\'m a teapot'),
                        content: Image.memory(image.data!),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Approve'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: const Text('Dio Task'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final data = await http.get(url);
  // final data = await Dio().get(url.toString());
  if (data.statusCode == 200) {
    return data.body;
  } else {
    throw Exception('Something went wrong');
  }
}

final counterProvider = riverpod.StateProvider<int>((ref) => 0);
