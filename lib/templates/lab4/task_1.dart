import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Task1 extends StatelessWidget {
  final String text;
  const Task1({
    super.key, required this.text
  });
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text)
          ],
          )
        
        
      ),
    );
  }
}