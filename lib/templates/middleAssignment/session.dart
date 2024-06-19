import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data.dart';

class SessionScreen extends ConsumerWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Session',
          style: TextStyle(color: Colors.white)
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan[400],
      ),
      body: const Center(
        child: Text('Session'),
      ),
    );
  }
}