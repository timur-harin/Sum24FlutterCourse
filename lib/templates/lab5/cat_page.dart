import 'package:flutter/material.dart';
class CatStatusCodePage extends StatelessWidget {
  final String statusCode;

  const CatStatusCodePage({Key? key, required this.statusCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network('https://http.cat/$statusCode'),
      ),
    );
  }
}