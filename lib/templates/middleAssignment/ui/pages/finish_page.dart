import 'dart:async';

import 'package:education/templates/middleAssignment/providers/cycles_provider.dart';
import 'package:education/templates/middleAssignment/providers/duration_provider.dart';
import 'package:education/templates/middleAssignment/providers/shower_take_provider.dart';
import 'package:education/templates/middleAssignment/providers/tempreture_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/data/shower_take.dart';


class FinishShowerPage extends ConsumerStatefulWidget {
  const FinishShowerPage({super.key});

  @override
  ConsumerState<FinishShowerPage> createState() => _FinishShowerPageState();
}

class _FinishShowerPageState extends ConsumerState<FinishShowerPage> {
  final TextEditingController rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finished!', style: TextStyle(color: Color(0xFF123C69)),),
        backgroundColor: Color(0xFFEEE2DC),
      ),
      backgroundColor: Color(0xFFEEE2DC),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.wine_bar,
              size: 300,
              color: Color(0xFFAC3B61),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Overall Cycles: ${ref.watch(cyclesProvider)}', style: TextStyle(color: Color(0xFF123C69)),),
                Text('Overall Duration: ${ref.watch(durationProvider)}', style: TextStyle(color: Color(0xFF123C69)),),
              ],
            ),

            FractionallySizedBox(
              widthFactor: 0.5,
              child: 
              Column(
                children: [
                  TextField(
                    controller: rateController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Rate the activity!',
                    ),
                    style: const TextStyle(
                      color: Color(0xFF123C69)
                    ),
                  ),   
                ]
              )
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: Text('Back'),
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF123C69)),
                  foregroundColor: WidgetStateProperty.all<Color>(Color(0xFFEEE2DC))
                ),
            ),

          ],
        ),
      )
    );
  }
}