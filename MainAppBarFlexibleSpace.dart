import 'package:flutter/material.dart';

class MainAppBarFlexibleSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Colors.lightBlueAccent,
                Colors.redAccent
              ]
          )
      ),
    );
  }
}
