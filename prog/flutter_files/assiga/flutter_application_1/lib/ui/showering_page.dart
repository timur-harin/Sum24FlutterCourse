import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/congratulation_page.dart';
import 'package:flutter_application_1/ui/starting_session.dart';
import 'dart:async';
import 'package:timer_count_down/timer_count_down.dart';
import "stats_button.dart";
import 'stats_page.dart';
import 'package:intl/intl.dart';

import 'dissapointing_page.dart';

class MyNavigationController {
  final BuildContext context;

  MyNavigationController(this.context);
}

class HotShower extends StatelessWidget {
  final int hotSeconds;
  final int coldSeconds;
  const HotShower(
      {super.key, required this.hotSeconds, required this.coldSeconds});

  @override
  Widget build(BuildContext context) {
    final controller = MyNavigationController(context);
    return Countdown(
      seconds: hotSeconds,
      build: (BuildContext context, double time) {
        return CupertinoPageScaffold(
          backgroundColor: CupertinoColors.destructiveRed,
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(
              child: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            trailing: CupertinoButton(
              child: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ColdShower(
                      coldSeconds: coldSeconds,
                    ),
                  ),
                );
              },
            ),
            middle: const Text('Hot Shower'),
            backgroundColor: CupertinoColors.destructiveRed,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enjoy the shower 🥵",
                  style: TextStyle(fontSize: 20, color: CupertinoColors.white),
                ),
                Countdown(
                  seconds: hotSeconds,
                  build: (BuildContext context, double time) => Text(
                      time.toString(),
                      style: const TextStyle(color: Colors.white)),
                  interval: const Duration(milliseconds: 100),
                  onFinished: () {
                    print('x');
                  },
                )
              ],
            ),
          ),
        );
      },
      interval: const Duration(milliseconds: 100),
      onFinished: () {
        Future.delayed(
          Duration.zero,
          () {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => ColdShower(
                  coldSeconds: coldSeconds,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ColdShower extends StatelessWidget with ChangeNotifier {
  final int? coldSeconds;
  ColdShower({super.key, this.coldSeconds});

  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: coldSeconds ?? 1,
      build: (BuildContext context, double time) {
        return CupertinoPageScaffold(
          backgroundColor: CupertinoColors.activeBlue,
          navigationBar: CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            trailing: CupertinoButton(
              child: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DissapointingPage(),
                  ),
                );
              },
            ),
            middle: const Text('Cold Shower'),
            backgroundColor: CupertinoColors.activeBlue,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Suffer 🥶",
                  style: TextStyle(fontSize: 20, color: CupertinoColors.white),
                ),
                Countdown(
                  seconds: coldSeconds ?? 1,
                  build: (BuildContext context, double time) => Text(
                      time.toString(),
                      style: const TextStyle(color: Colors.white)),
                  interval: const Duration(milliseconds: 100),
                  onFinished: () {},
                )
              ],
            ),
          ),
        );
      },
      interval: const Duration(milliseconds: 100),
      onFinished: () {

        notifyListeners();
        print("XX");
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (context) => const CongratulationsPage()));
      },
    );
  }
}

class ShoweringPage extends StatefulWidget {
  final int hotSeconds;
  final int coldSeconds;
  const ShoweringPage(
      {super.key, required this.hotSeconds, required this.coldSeconds});

  @override
  State<ShoweringPage> createState() => _ShoweringPageState();
}

class _ShoweringPageState extends State<ShoweringPage> {
  @override
  Widget build(BuildContext context) {
    return HotShower(
        hotSeconds: widget.hotSeconds, coldSeconds: widget.coldSeconds);
  }
}
