
import 'package:flutter/material.dart';

class screen2 extends StatelessWidget{
  final String res;
  const screen2({
    required this.res,
    super.key,
  });
  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(
    ),
    body: Center(
   child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(res),
        
    ],
    ),
    )
    );
  }

  
}