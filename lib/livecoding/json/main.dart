import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Placeholder API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JsonPlaceholderDemo(),
    );
  }
}

class JsonPlaceholderDemo extends StatefulWidget {
  @override
  _JsonPlaceholderDemoState createState() => _JsonPlaceholderDemoState();
}

class _JsonPlaceholderDemoState extends State<JsonPlaceholderDemo> {
  String _responseBody = '';

  Future<void> _fetchData() async {
    final response =
        await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      setState(() {
        _responseBody = response.body;
      });
    } else {
      setState(() {
        _responseBody = 'Failed to load data';
      });
    }
  }

  Future<void> _sendData() async {
    final response = await http.post(
      Uri.parse('http://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': 'foo',
        'body': 'bar',
        'userId': '1',
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        _responseBody = response.body;
      });
    } else {
      setState(() {
        _responseBody = 'Failed to post data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Placeholder API Demo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(_responseBody),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _fetchData,
            tooltip: 'Fetch Data',
            child: Icon(Icons.download),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _sendData,
            tooltip: 'Send Data',
            child: Icon(Icons.upload),
          ),
        ],
      ),
    );
  }
}
