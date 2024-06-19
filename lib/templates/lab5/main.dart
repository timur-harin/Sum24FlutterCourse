import 'package:flutter/material.dart';
import 'user.dart';
import 'post.dart';
import 'comment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _showData(context, 'Comments', fetchComments),
                child: const Text('View Comments'),
              ),
              ElevatedButton(
                onPressed: () => _showData(context, 'Posts', fetchPosts),
                child: const Text('View Posts'),
              ),
              ElevatedButton(
                onPressed: () => _showData(context, 'Users', fetchUsers),
                child: const Text('View Users'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter status code',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final statusCode = int.tryParse(_controller.text);
                  if (statusCode != null) {
                    Navigator.of(context).pushNamed('/status', arguments: statusCode);
                  } else {
                    _showErrorDialog(context, 'Please enter a valid number');
                  }
                },
                child: const Text('Show Cat Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showData<T>(BuildContext context, String title, Future<List<T>> Function() fetchData) async {
    try {
      final data = await fetchData();
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text(title),
          children: [
            for (var item in data) ListTile(title: Text(item.toString())),
          ],
        ),
      );
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/status':
        if (settings.arguments is int) {
          final int statusCode = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => StatusPage(statusCode: statusCode),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Image.network('https://http.cat/404'),
        ),
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  final int statusCode;

  StatusPage({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network('https://http.cat/$statusCode'),
      ),
    );
  }
}
