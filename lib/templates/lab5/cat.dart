import 'package:flutter/material.dart';

class Cats extends StatelessWidget {
  final String statusCode;
  const Cats({Key? key, required this.statusCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Center(
        child: Image.network('https://http.cat/${statusCode}'),
      ),
    );
  }
}