import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StatsNullPage extends StatelessWidget {
  const StatsNullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        middle: Text('Statistics'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You do not have any sessions yet',
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            ),
            const SizedBox(height: 20),
            Text(
              'Start a new session to view your statistics',
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
