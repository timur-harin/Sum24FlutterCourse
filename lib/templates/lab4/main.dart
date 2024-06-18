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
                // TODO
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                ref.read(jsonProvider.notifier).state = result;
              },
              child: Text('Async/Await Task'),
            ),
            SizedBox(height: 10),
            Text(ref.watch(jsonProvider)),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state++;
              },
              child: Text(ref.watch(counterProvider).toString()),
              // Text('Provider Task'),
            ),
            SizedBox(height: 10),
            /////////////////////////////
            
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(moveProvider.notifier).increment();
              },
              child: Text(ref.watch(moveProvider).toString()),
              // Text('Riverpod Task'),
            ),
            SizedBox(height: 10),
            ///////////////////////////
            
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                String result = await fetchData();
                ref.read(httpProvider.notifier).state = result;
              },
              child: Text('HTTP Task'),
            ),
            SizedBox(height: 10),
            Text(ref.watch(httpProvider)),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                Response response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
                ref.read(dioProvider.notifier).state = response.data.toString();
              },
              child: Text('Dio Task'),
            ),
            SizedBox(height: 10),
            Text(ref.watch(dioProvider)),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'

  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return response.body;
  }
  else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
  // return 'data';
}

final counterProvider = StateProvider<int>((ref) => 0);
final jsonProvider = StateProvider<String>((ref) => '');
final httpProvider = StateProvider<String>((ref) => '');
final dioProvider = StateProvider<String>((ref) => '');

// TODO create a state notifier
final moveProvider = StateNotifierProvider<MoveNotifier, int>((ref) {
  return MoveNotifier();
});

// TODO create class for state notifier
class MoveNotifier extends StateNotifier<int> {
  MoveNotifier() : super(0);

  void increment() {
    state++;
  }
}