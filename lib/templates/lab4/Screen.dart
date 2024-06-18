import 'package:flutter/material.dart';


class Screen extends StatelessWidget {
  const Screen({super.key, required this.information});

  final String information;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen for lab4'),
      ),
      body: Center(
        child: Text(information),
      )
    );
  }
}