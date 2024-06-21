import 'dart:async';

import 'package:education/templates/middleAssignment/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_state_provider.dart';

class ShowerPage extends ConsumerStatefulWidget {
  const ShowerPage({super.key});

  @override
  ConsumerState<ShowerPage> createState() => _ShowerPageState();
}

class _ShowerPageState extends ConsumerState<ShowerPage> {
  int duration = 0;
  int durationLeft = 0;
  int cyclesLeft = 0;

  void _startCountDown(Pair pair) {
    duration = pair.first;
    durationLeft = pair.first;
    cyclesLeft = pair.second;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (durationLeft > 0) {
        setState(() {
          durationLeft--;
        });
      } else {
        if (cyclesLeft > 0) {
          durationLeft = duration;
          cyclesLeft--;
        }
        if (cyclesLeft == 0) {
          timer.cancel();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              durationLeft.toString(),
              style: TextStyle(fontSize: 50),
            ),
            MaterialButton(
              onPressed: () {
                _startCountDown(ref.watch(settingsStateProvider));
              },
              child: Text(
                'S T A R T',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepOrange,
            )
          ],
        ),
      ),
    );
  }
}
