import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final String text;
  const Screen({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(text)
    );
  }
}
