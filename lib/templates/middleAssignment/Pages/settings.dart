import 'package:flutter/material.dart';

class setting extends StatelessWidget {
  const setting({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}