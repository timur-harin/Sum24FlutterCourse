import 'package:flutter/material.dart';
import 'cat_status_code.dart';

class StatusPage extends StatelessWidget {
  final CatStatusCode catStatusCode;

  StatusPage({required this.catStatusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Code: ${catStatusCode.statusCode}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Status Code: ${catStatusCode.statusCode}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              catStatusCode.message,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
