import 'dart:convert';

import 'package:education/templates/lab4/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:education/templates/lab4/labProvider.dart';

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
  Widget build(BuildContext context, ref) {
    LabProvider provider = LabProvider();
    final cnt = ref.watch(countProvider);
    final cnt2 = ref.watch(riverpodProvider)._cnt;
    String scr2 = "https://http.cat/status/100";
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Counter: " + cnt.toString()),
            Text("Riverpod counter: " + cnt2.toString()),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Screen(text: result)));
              },
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                ref.read(countProvider.notifier).add();
                //cnt = ref.watch(countProvider);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage()));
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Exercise 3 - Use Riverpod for state management
                // Increment the counter
                ref.read(riverpodProvider.notifier).inc();
              },
              child: Text('Riverpod Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO 
                // Exercise 4 - Make an HTTP request using the HTTP package
                String result = await fetchData();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Screen(text: result)));
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                // TODO
                // Exercise 5 - Make an HTTP request using Dio and show it in App Screen
                String result = await fetchData2();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Screen(text: result)));
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

  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.get(url);
  return utf8.decode(response.bodyBytes);
}
Future<String> fetchData2() async {
  // TODO get json from url and show as text
  // 'https://jsonplaceholder.typicode.com/posts/1'
  Dio dio = Dio();

  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await dio.get(url.toString());
  if (response.statusCode == 200) {
    return(response.data.toString());
  }
  else {
    return('Request failed with status: ${response.statusCode}.');
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
final countProvider = StateNotifierProvider<CountNotifier, int>((ref) {
  return CountNotifier(0);
});

// TODO create class for state notifier
class CountNotifier extends StateNotifier<int>{
  CountNotifier(super.state);
  int _cnt = 0;
  void add(){
    _cnt++;
    state = _cnt;
  }
  int get cnt => _cnt;
  set cnt(int value) => _cnt = value;
}

final riverpodProvider = ChangeNotifierProvider((ref) {
  return NewNotifier();
});
class NewNotifier extends ChangeNotifier{
  int _cnt = 0;
  get cnt => _cnt;
  void inc(){
    _cnt++;
    notifyListeners();
  }
}