import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:provider/provider.dart' as legacy_provider;

void main() {
  runApp(
    legacy_provider.ChangeNotifierProvider(
      create: (_) => CounterNotifierLegacy(),
      child: MyApp(),
    ),
  );
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

class MyHomePage extends ConsumerStatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  String asyncAwaitResult = "Press the button to fetch data";

  @override
  Widget build(BuildContext context) {
    final counterProviderState = legacy_provider.Provider.of<CounterNotifierLegacy>(context).count;
    final riverpodCounter = ref.watch(counterProviderRiverpod);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Ex 1
            ElevatedButton(
              onPressed: () async {
                String result = await fetchData();
                setState(() {
                  asyncAwaitResult = result;
                });
              },
              child: Text('Async/Await Task'),
            ),

            Text(asyncAwaitResult),
            
            // Ex 2
            Text('Provider Counter: $counterProviderState'),

            ElevatedButton(
              onPressed: () {
                legacy_provider.Provider.of<CounterNotifierLegacy>(context, listen: false).increment();
              },
              child: Text('Provider Task'),
            ),

            // Ex 3
            Text('Riverpod Counter: $riverpodCounter'),

            ElevatedButton(
              onPressed: () {
                ref.read(counterProviderRiverpod.notifier).increment();
              },
              child: Text('Riverpod Task'),
            ),

            // Ex 4
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

                if (response.statusCode == 200) {
                  final data = response.body;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('HTTP Task'),
                      content: Text(data),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  throw Exception('Failed to load data');
                }
              },
              child: Text('HTTP Task'),
            ),

            // Ex 5
            ElevatedButton(
              onPressed: () async {
                final dio = Dio();
                final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                final data = response.data.toString();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Dio Task'),
                    content: Text(data),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
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
// Ex 1
Future<String> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "Request failed with status: ${response.statusCode}.";
  }
}


final counterProvider = StateProvider<int>((ref) => 0);

// Ex 2
class CounterNotifierLegacy extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}



// Ex 3
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}
final counterProviderRiverpod = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
