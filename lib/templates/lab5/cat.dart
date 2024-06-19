import 'package:flutter/material.dart';

class CatPage extends StatefulWidget {
  final int statusCode;

  CatPage({required this.statusCode});

  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Code ${widget.statusCode}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://http.cat/${widget.statusCode}'),

          ],
        )
      ),
    );
  }
}