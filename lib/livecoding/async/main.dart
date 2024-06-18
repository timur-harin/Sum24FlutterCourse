
// import 'package:http/http.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  getJson();
  runApp(ProviderScope(child: MyApp()));
}

void getJson() async {
    Dio dio = Dio();

  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await dio.get(url.toString());

  if (response.statusCode == 200) {
    print(response.data);
  }
  else {
    print('Request failed with status: ${response.statusCode}.');
  }

}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/one',
      routes: {
        '/one': (context) => const FirstPage(),
        '/two': (context) => const SecondPage(),
      },
    );
  }
}

final moveProvider = StateNotifierProvider<MoveNotifier, int>((ref) {
  return MoveNotifier();
});

class MoveNotifier extends StateNotifier<int> {
  MoveNotifier() : super(0);

  int _moveCount = 0;

  void move() {
    _moveCount++;
    state = _moveCount;
  }

  int get moveCount => _moveCount;

  set moveCount(int value) => _moveCount = value;
}

class FirstPage extends ConsumerStatefulWidget {
  const FirstPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends ConsumerState<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Move Count: ${ref.watch(moveProvider)}',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(moveProvider.notifier).move();
          Navigator.pushNamed(context, '/two');
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class SecondPage extends ConsumerStatefulWidget {
  const SecondPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Move Count: ${ref.watch(moveProvider)}',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(moveProvider.notifier).move();
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

