import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeButtonWidget extends ConsumerWidget {
  const HomeButtonWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return IconButton(
        icon: const Icon(Icons.home),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
    );
  }
}