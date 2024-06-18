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
    return const ProviderScope(
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
        title: const Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                final jsonProvider = StateProvider<String>((ref) => '');
                ref.read(jsonProvider.notifier).state = result;
                 showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(ref.watch(jsonProvider)),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Async/Await Task'),
            ),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) {
                final counterProvider = StateProvider<int>((ref) => 0);
                final counter = ref.watch(counterProvider);
                return ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).state++;
                  },
                  child: Text('Provider Task: $counter'),
                );
              }
            ),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) {
                final counter = ref.watch(counterRiverpodNotifierProvider);
                return ElevatedButton(
                  onPressed: () {
                    ref.read(counterRiverpodNotifierProvider.notifier).increment();
                  },
                  child: Text('Riverpod Task: $counter'),
                );
              }
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                final httpProvider = StateProvider<String>((ref) => '');
                ref.read(httpProvider.notifier).state = result;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(ref.watch(httpProvider)),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: const Text('HTTP Task'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Response response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
                final dioProvider = StateProvider<String>((ref) => '');
                NetworkImage image = NetworkImage("https://http.error/${response.statusCode.toString()}");
                ref.read(imageProvider.notifier).state = image;
                ref.read(dioProvider.notifier).state = response.toString();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Consumer(
                      builder: (context, ref, child) {
                        final image = ref.watch(imageProvider);
                        final responseText = ref.watch(dioProvider);
                        return  Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(image: image),
                            const SizedBox(height: 10),
                            Text(responseText),
                          ],
                        );
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
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
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

class CounterRiverpodState extends StateNotifier<int> {
  CounterRiverpodState() : super(0);

  void increment() => state++;
}

final counterRiverpodNotifierProvider = StateNotifierProvider<CounterRiverpodState, int>((ref) {
  return CounterRiverpodState();
});

final imageProvider = StateProvider<NetworkImage>((ref) => const NetworkImage('https://www.istockphoto.com/ru/%D1%84%D0%BE%D1%82%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B8%D0%B8/%D0%BB%D0%B5%D1%81'));