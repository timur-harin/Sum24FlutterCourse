
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http;ab/http.dart' as http;
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
    final counter = ref.watch(counterProvider);
    final notifier = ref.watch(stateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AsyncAwaitTaskButton(),
            ProviderTaskButton(ref: ref, counter: counter),
            RiverpodTaskButton(notifier: notifier),
            HttpTaskButton(),
            DioTaskButton(),
          ],
        ),
      ),
    );
  }
}

class AsyncAwaitTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String result = await fetchData();
        Navigator.push(context, MaterialPageRoute(builder: (context) => Task1(text: result)));
      },
      child: Text('Async/Await Task'),
    );
  }

  Future<String> fetchData() async {
    final link = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

    if (link.statusCode == 200) {
      return utf8.decode(link.bodyBytes); // Преобразование Uint8List в строку
    } else {
      throw Exception('Failed to load Data');
    }
  }
}

class ProviderTaskButton extends StatelessWidget {
  final int counter; // Добавляем counter как параметр
  final WidgetRef ref;

  const ProviderTaskButton({Key? key, required this.counter, required this.ref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ref.read(counterProvider.notifier).state++;
      },
      child: Text('Provider Task: $counter'), // Теперь counter определен
    );
  }
}

class RiverpodTaskButton extends StatelessWidget {
  final CounterNotifier notifier;

  const RiverpodTaskButton({Key? key, required this.notifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        notifier.increment();
      },
      child: Text('Riverpod Task: ${notifier.counter}'),
    );
  }
}

class HttpTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
        if (response.statusCode == 200) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Task1(text: response.body)));
        } else {
          print('Failed to load Data');
        }
      },
      child: Text('HTTP Task'),
    );
  }
}

class DioTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final dio = Dio();
        final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
        if (response.statusCode == 200) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Task1(text: response.data.toString())));
        } else {
          print('Failed to load Data');
        }
      },
      child: Text('Dio Task'),
    );
  }
}

class Task1 extends StatelessWidget {
  final String text;
  const Task1({Key? key, required this.text}) : super(key: key);

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text)
          ],
        ),
      ),
    );
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class CounterNotifier extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

final stateNotifierProvider = ChangeNotifierProvider((ref) => CounterNotifier());