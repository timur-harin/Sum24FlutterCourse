import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final riverpodCounterProvider =
    StateNotifierProvider<RiverpodCounterNotifier, int>(
        (ref) => RiverpodCounterNotifier());

class RiverpodCounterNotifier extends StateNotifier<int> {
  RiverpodCounterNotifier() : super(0);

  void increment() {
    state++;
  }
}

final counterProvider = StateProvider<int>((ref) => 0);
final httpDataProvider = StateProvider<String?>((ref) => null);
final dioDataProvider = StateProvider<String?>((ref) => null);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo cool app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int counter = ref.watch(counterProvider);
    int riverpodCounter = ref.watch(riverpodCounterProvider);
    String? httpData = ref.watch(httpDataProvider);
    String? dioData = ref.watch(dioDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tasks'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  try {
                    String result = await fetchData();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(result)));
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                },
                child: Text('Async/Await Task'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).state++;
                },
                child: Text('Provider Task'),
              ),
              Text('Provider Counter Value: $counter'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(riverpodCounterProvider.notifier).increment();
                },
                child: Text('Riverpod Task'),
              ),
              Text('Riverpod Counter Value: $riverpodCounter'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await fetchHttpData(ref);
                },
                child: Text('HTTP Task'),
              ),
              if (httpData != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(httpData, textAlign: TextAlign.center),
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await fetchDioData(ref);
                },
                child: Text('Dio Task'),
              ),
              if (dioData != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(dioData, textAlign: TextAlign.center),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> fetchData() async {
  try {
    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data.toString();
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

Future<void> fetchHttpData(WidgetRef ref) async {
  try {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      ref.read(httpDataProvider.notifier).state = response.body;
    } else {
      ref.read(httpDataProvider.notifier).state = 'Failed to load data';
    }
  } catch (e) {
    ref.read(httpDataProvider.notifier).state = 'Error: $e';
  }
}

Future<void> fetchDioData(WidgetRef ref) async {
  try {
    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
    ref.read(dioDataProvider.notifier).state = response.data.toString();
  } catch (e) {
    ref.read(dioDataProvider.notifier).state = 'Error: $e';
  }
}
