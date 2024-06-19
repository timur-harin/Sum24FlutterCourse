import 'package:flutter/material.dart';

class CatStatusCodePage extends StatelessWidget {
  final String statusCode;

  const CatStatusCodePage({Key? key, required this.statusCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://http.cat/${statusCode.split('/').last}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Code: ${statusCode.split('/').last}'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
