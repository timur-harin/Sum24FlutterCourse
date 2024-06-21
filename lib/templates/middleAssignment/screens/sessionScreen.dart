import 'package:education/templates/middleAssignment/providers/colorProvider.dart';
import 'package:education/templates/middleAssignment/widgets/homeButtonWidget.dart';
import 'package:education/templates/middleAssignment/widgets/timerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';


class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key});

  @override
  ConsumerState<SessionScreen> createState() => _SessionscreenState();
}

class _SessionscreenState extends ConsumerState<SessionScreen> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        Color colorNotifier = ref.watch(colorNotifierProvider);
        
        return Scaffold(
          appBar: AppBar(
            actions: const [
              HomeButtonWidget(),
            ],
            title: const Text(
              "Contrast shower session",
              style: TextStyle(
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Colors.black,
                ),
              ],
          ),
              ),
            backgroundColor: Colors.blue[900],
          ),
          body: Container(
            color: colorNotifier,
            child: const Timerwidget(),
          ),
        );
      },
    );
  }
}