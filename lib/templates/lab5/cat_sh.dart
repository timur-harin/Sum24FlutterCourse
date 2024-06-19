import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GeneratedPage extends StatefulWidget {
  const GeneratedPage({super.key, required this.status});
  final String status;

  @override
  State<GeneratedPage> createState() => _GeneratedPageState();
}

class _GeneratedPageState extends State<GeneratedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.status),
      ),
      body: Center(
        child: Text(widget.status),
      ),
    );
  }
}

