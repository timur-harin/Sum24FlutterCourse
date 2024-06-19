import 'dart:async';

import 'package:education/templates/middleAssignment/providers/cycles_provider.dart';
import 'package:education/templates/middleAssignment/providers/duration_provider.dart';
import 'package:education/templates/middleAssignment/providers/shower_take_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/data/shower_take.dart';


class FinishShowerPage extends ConsumerStatefulWidget {
  const FinishShowerPage({super.key});

  @override
  ConsumerState<FinishShowerPage> createState() => _FinishShowerPageState();
}

class _FinishShowerPageState extends ConsumerState<FinishShowerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finished!'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.wine_bar,
              size: 300,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Overall Cycles: ${ref.watch(cyclesProvider)}'),
                Text('Overall Duration: ${ref.watch(durationProvider)}'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: const Text('Back')
            ),

          ],
        ),
      )
    );
  }
}