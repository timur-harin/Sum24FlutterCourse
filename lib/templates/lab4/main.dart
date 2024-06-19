import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http/http.dart';
//import 'package:provider/provider.dart' hide ChangeNotifierProvider;


void main() {
  runApp(MyApp());
  //getJson();
}


class CountProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
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

// void getJson() async {
//     final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

//     final response = await get(url);
//     if (response.statusCode == 200) {
//       print(response.body);
//   }
// }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //CountProvider countProvider3 = Provider.of<CountProvider>(context, listen: false);
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
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task'),
            ),
            Text('Provider Task: ${ref.watch(counterProvider).toString()}'),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(counterProvider2.notifier).incrementCounter();
              },
              child: Text('Riverpod Task'),
            ),
            Text('Riverpod Task: ${ref.watch(counterProvider2).counter.toString()}'),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
                final response = await get(url);
                ref.read(HTTPProvider.notifier).state = response.body;
              },
              child: Text('HTTP Task'),
            ),
            Text('HTTP Task: ${ref.watch(HTTPProvider)}'),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                Dio dio = Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                ref.read(DioProvider.notifier).state = response.data.toString();
              },
              child: Text('Dio Task'),
            ),
            Text('Dio Task: ${ref.watch(DioProvider)}'),
          ],
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await get(url);
    String data = '';
    if (response.statusCode == 200) {
      data = response.body;
      return data;
  }
  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'

  return data;
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
final counterProvider2 = ChangeNotifierProvider((ref) => CountProvider());

// TODO create class for state notifier

final HTTPProvider = StateProvider<String>((ref) => '');

final DioProvider = StateProvider<String>((ref) => '');