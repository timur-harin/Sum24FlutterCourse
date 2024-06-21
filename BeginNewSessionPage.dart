import 'package:flutter/material.dart';
import 'MainAppBarFlexibleSpace.dart';

class BeginNewSessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start new shower session"),
        flexibleSpace: MainAppBarFlexibleSpace(),
        automaticallyImplyLeading: false,
      ),
      body: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Back"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/newSession");
              },
              child: const Text("Start"),
            )
          ]
      ),
    );
  }

}
