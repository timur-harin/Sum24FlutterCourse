import 'package:flutter/cupertino.dart';

class CongratulationsPage extends StatelessWidget {
  const CongratulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        middle: Text('Hell Yeah!'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Congratulations!",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "You did it!",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 300),
            const Text(
              "Now go Home and watch some stats",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 45),
            CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: const Text("Go Home"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
