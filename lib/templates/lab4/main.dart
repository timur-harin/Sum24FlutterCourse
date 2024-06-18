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
  const MyHomePage({super.key});

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
                print(result);
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
                // Exercise 2 - Use Provider for state management
                // Increment the counter
              },
              child: Text('Provider Task ${ref.watch(counterProvider)}'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterNotifier.notifier).increment();
                print('Riverpod Task ${ref.watch(counterNotifier)}');
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                await httpTask();
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> result = await dioTask();
                ref.read(responseProvider.notifier).state = result["response"].toString();
                ref.read(statusCodeProvider.notifier).state = result["status_code"];
              },
              child: Text('Dio Task'),
            ),
            Text(ref.watch(responseProvider)),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  var response = await http.get(url);


  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'

  return response.body;
}

Future<String> httpTask() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "Error. Status code ${response.statusCode}";
  }
}


Future<Map<String, dynamic>> dioTask() async {
  final dio = Dio();
  final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
  // print(response);
  return {"status_code": response.statusCode, "response": response.data};
}

final counterProvider = StateProvider<int>((ref) => 0);
final counterNotifier = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier(0);
});
final responseProvider = StateProvider<String>((ref) => "no response");
final statusCodeProvider = StateProvider<int>((ref) => 404);


class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(super.state);

  void increment() {
    state++;
  }


}
// TODO create a state notifier
// final 

// TODO create class for state notifier
