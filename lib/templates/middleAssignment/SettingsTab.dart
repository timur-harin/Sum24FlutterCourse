import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget{
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Insert settings for shower cycles")
      ],
    );
  }
}