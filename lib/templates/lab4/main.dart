import 'package:education/templates/lab4/screen2.dart';
import 'package:education/templates/middleAssignment/screen2.dart';
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
class MyHomePage extends ConsumerStatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  String _text='';
  @override
  Widget build(BuildContext context) {
    final count =ref.watch(counterProvider);
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
                // TODO1
                // Exercise 1 - Perform an async operation using async/await
                String result = await fetchData();
                setState(() {
                  _text=result;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => screen2(
                  res: _text)));
              },
              child: Text('Async/Await Task'),
              
            ),
            ElevatedButton(
              onPressed: () {
                // Exercise 2 - Use Provider for state management
                // Increment the counter
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Provider Task, count $count'),
            ),
            Consumer(
              builder: (context, ref, child){
                final CounterNotifier =ref.watch(CounterNotifierProvider);
                return Column(
                  children: [
                      ElevatedButton(
                        onPressed: ()  {
                          ref.read(CounterNotifierProvider.notifier).increment();
                        },
                        child: Text('Riverpod Task , count: ${CounterNotifier.counter}'),
                      ),
                  ],
                );
              }
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(
                  Uri.parse('https://jsonplaceholder.typicode.com/posts/1')
                );
                if (response.statusCode ==200){
                  setState(() {
                     _text=response.body;
                  });
                }else{
                  throw Exception('Failed to load data');
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) => screen2(
                  res: _text)));
              
              },
              child: Text('HTTP Task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final dio =Dio();
                final response= await dio.get('https://jsonplaceholder.typicode.com/posts/1');
                if (response.statusCode ==200){
                  setState(() {
                    _text =response.data.toString();
                  });
                }else{
                  throw Exception('Failed to load data');
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) => screen2(
                  res: _text)));
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
  final url = 'https://jsonplaceholder.typicode.com/posts/1';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return response.body; // return the JSON response as a string
  } else {
    return 'Error: ${response.statusCode}';
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class CounterNotifier with ChangeNotifier{
  int _counter=0;
  int get counter =>_counter;
  void increment(){
    _counter++;
    notifyListeners();
  }
}

final CounterNotifierProvider =
ChangeNotifierProvider<CounterNotifier>((ref) => CounterNotifier());
