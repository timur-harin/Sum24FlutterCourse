import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

final pageProvider = StateProvider<String?>((ref) {
  return null;
});


void main() {
  runApp(ProviderScope(child: MyApp()));
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

  String? textForTaskOne;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageText = ref.watch(pageProvider);
    final counter = ref.watch(counterProvider);
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
                ref.read(pageProvider.notifier).state = result;
              },
              child: Text('Async/Await Task'),
            ),
            if (pageText != null)
              Padding(padding: const EdgeInsets.all(8.0),
              child: Text(pageText)
              ),
            if (pageText != null)
              const Padding(padding: EdgeInsets.all(8.0),
              child: Image(
                image: NetworkImage(
                "https://media.tenor.com/t3dLLNaI50oAAAAM/cat-cats.gif"
                ),
              ),
              ) ,
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task'),
            ),
            Text("You've clicked the button $counter times"),
            ElevatedButton(
              onPressed: () {
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: Text('Riverpod Task'),
            ),
            Text("You've pressed another button ${ref.watch(counterNotifierProvider)}"),
            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
                  if (response.statusCode == 200) {
                    final data = response.body;
                    // Update the state with the fetched data
                    ref.read(pageProvider.notifier).state = data;
                  } else {
                    throw Exception("Failed to load data");
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  String result = await fetchDioData();
                  ref.read(pageProvider.notifier).state = result;
                } catch (e) {
                  print (e);
                }
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
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception("Failed to load data");
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

// TODO create a state notifier
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}
// final 
Future<String> fetchDioData() async {
  try {
    final response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
    if (response.statusCode == 200) {
      return response.data.toString();
    } else {
      throw Exception("Failed to load data");
    }
  } catch (e) {
    throw Exception("Failed to load data: $e");
  }
}

