import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final counter = ref.read(counterProvider);
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
              child: Text('Async/Await Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
                int res = ref.watch(counterProvider);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(res.toString()),
                  ),
                );
              },
              child: Text('Provider Task'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(Provider.notifier).increment();
              },
              child: Text('Riverpod Task ' + ref.watch(Provider).toString()),
            ),
            ElevatedButton(
              onPressed: () async {
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
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200){
    return response.body;
  }
  else{
    throw Exception('Failed');
  }
}
final counterProvider = StateProvider<int>((ref) => 0);

final Provider = StateNotifierProvider<Notifier, int>((ref) {
  return Notifier();

});

class Notifier extends StateNotifier<int> {
  Notifier() : super(0);

  void increment() {
    state++;
  }
}
Future<String> fetchDioData() async {
  try {
    final response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data.toString();
  } catch (e) {
    return "Error: $e";
  }
}

