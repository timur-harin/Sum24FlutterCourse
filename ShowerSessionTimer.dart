import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerSessionTimer extends ConsumerStatefulWidget {
  const ShowerSessionTimer(this._minutes, this._seconds, this._nextPhase, this.movesLeft, {super.key});
  final int _minutes, _seconds;
  final String _nextPhase;
  final int movesLeft;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ShowerSessionTimer(Duration(seconds: _seconds, minutes: _minutes), _nextPhase, movesLeft);
  }
}

class _ShowerSessionTimer extends ConsumerState<ShowerSessionTimer> {
  _ShowerSessionTimer(this._phaseDuration, this.nextPhasePage, this.movesLeft);
  final String nextPhasePage;
  final int movesLeft;
  Duration _phaseDuration;
  Timer? _timer;

  @override void initState() {
    super.initState();
    startColdTimer();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _phaseDuration.inMinutes;
    final seconds = _phaseDuration.inSeconds.remainder(60);
    return Container(
      child: Text("$minutes:$seconds"),
    );
  }

  void decrementTimer() {
    const second = -1;
    setState(() {
      _phaseDuration = Duration(seconds: _phaseDuration.inSeconds + second);
      if (_phaseDuration.inSeconds <= 0) {
        _timer?.cancel();
        if (movesLeft > 0) {
          Navigator.of(context).pushNamed(nextPhasePage,
              arguments: {
                  "movesLeft" : movesLeft - 1
              });
        } else {
          Navigator.of(context).pushNamed("/endSession");
        }
      }
    });
  }

  void startColdTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1), (_) => decrementTimer()
    );
  }
}
