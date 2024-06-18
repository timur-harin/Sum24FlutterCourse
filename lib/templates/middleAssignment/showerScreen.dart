import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerScreen extends ConsumerWidget{
  const ShowerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion', style: TextStyle(fontSize: 30.0),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [


          ],
        ),
      ),
      //backgroundColor: Colors.cyanAccent,
    );
  }
}