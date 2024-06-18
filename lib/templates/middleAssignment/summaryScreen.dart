import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryScreen extends ConsumerWidget{
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Contrast Shower Companion', style: TextStyle(fontSize: 30.0),),

          ],
        ),
      ),
      //backgroundColor: Colors.cyanAccent,
    );
  }
}