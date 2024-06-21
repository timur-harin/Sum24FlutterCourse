import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'starting_session.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        middle: Text('Home'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hi, Username!",
              textScaler: const TextScaler.linear(2),
              // style: CupertinoTheme.of(context).textTheme.l,
            ),
            const SizedBox(height: 30),
            const Text('Welcome back to showering! 🚿',
                // style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                textScaler: const TextScaler.linear(1.2)),
            const SizedBox(height: 300),
            CupertinoButton.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const StartingSession(),
                  ),
                );
                // Handle button press here
              },
              child: const Text('Start a new Shower Session!'),
            ),
          ],
        ),
      ),
    );
  }
}
