import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/ShowerProcess.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class BackgroundAnimation extends ConsumerStatefulWidget {
  const BackgroundAnimation({super.key});

  @override
  ConsumerState<BackgroundAnimation> createState() => _BackgroundAnimationState();
}
class _BackgroundAnimationState extends ConsumerState<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final isRunning = ref.watch(isRUnningProvider) ?? true;
    return Scaffold(
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(
          options:  ParticleOptions(
            spawnMaxRadius: 50,
            spawnMinSpeed: 15,
            particleCount: 70,
            spawnMaxSpeed: 40,
            spawnOpacity: 0.3,
            baseColor: isRunning ? Colors.blue : Colors.red,
          ),
        ),
        child: Showerprocess(),
      ),
    );
  }
}

