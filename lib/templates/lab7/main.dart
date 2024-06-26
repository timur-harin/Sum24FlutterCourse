import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
        child: MaterialApp(
      home: MyHomePage(title: 'Home Page', message: 'Hello Capibara!!!!',),
    )),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key, 
    required this.title,
    required this.message,
  });
  final String title;
  final String message;

  @override
  State<MyHomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:Container (
          child: Text(widget.message),
        ),
      ),
    );
  }
}
