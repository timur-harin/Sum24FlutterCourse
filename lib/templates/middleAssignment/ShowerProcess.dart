import 'package:education/templates/middleAssignment/newShower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/SessionResults.dart';
import 'dart:async';

final isRUnningProvider = StateProvider<bool?>((ref) => true);


class Showerprocess extends ConsumerStatefulWidget {
  const Showerprocess({super.key});
  @override
  ConsumerState<Showerprocess> createState() => _ShowerprocessState();
}

class _ShowerprocessState extends ConsumerState<Showerprocess> {
  int? NumOfCycles;
  int actualCycle = 0;
  int timeLeft = 0;
  bool isRunning = false;
  bool isCold = true;
  late Timer timer;
  int currentCycle = 1;
  int cnt = 0;
  bool isStarted = false;

  void startTimer(int NumOfCycles, int NumInCycle) {
    timeLeft = NumInCycle;
    isStarted = true;
    final cycles = NumOfCycles;
    const oneSec = Duration(seconds: 1);

    timer = new Timer.periodic(
        oneSec,
            (Timer timer) {
          if (isRunning){
            if (timeLeft == 0){
              if (cycles > 0){
                setState(() {
                  isCold = !isCold;
                  ref.read(isRUnningProvider.notifier).update((state) => isCold);
                  print(1);
                  timer.cancel();
                });
                NumOfCycles--;
                currentCycle++;
                startTimer(cycles-1, NumInCycle);
              }else{
                timer.cancel();
              }
            }else {
              setState(() {
                actualCycle++;
                timeLeft--;
              });
            }
          }
        }
    );
  }

  void pauseTimer() {
    if (!isRunning) return;
    isRunning = false;
  }

  void restume() {
    if (isRunning) return;
    isRunning = true;
  }

  @override
  Widget build(BuildContext context) {
    final seconds = ref.read(secondsProvider);
    final intervals = ref.read(IntervalsProvider) ?? 1;
    if (seconds == null){
      ref.read(secondsProvider.notifier).update((state) => 60);
    }
    NumOfCycles = intervals;

    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('$currentCycle / $NumOfCycles  current: ' + (isCold ? " cold" : " hot"), style: TextStyle(fontSize: 24.0)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:20),
                  child: ElevatedButton(
                      onPressed: (){
                        pauseTimer();
                      },
                      child: Icon(Icons.pause)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('$timeLeft', style: TextStyle(fontSize: 24.0)),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:
                    ElevatedButton(
                        onPressed: (){
                          ref.read(IntervalsProvider.notifier).update((state) => NumOfCycles);
                          if (cnt == 0){
                            cnt++;
                            isRunning = true;
                            startTimer(NumOfCycles! - 1, seconds!);
                          }
                          else{
                            restume();
                          }
                        },
                        child: Icon(Icons.play_arrow)
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                    onPressed: (){
                      setState(() {
                        isCold = true;
                        ref.read(isRUnningProvider.notifier).update((state) => isCold);
                      });
                      int secondsResult = 0;
                      if (isStarted == false){
                        currentCycle = 0;
                        secondsResult = 0;
                      }
                      else {
                        secondsResult =
                            seconds! * (currentCycle - 1) + seconds - timeLeft;
                      }
                      ref.read(IntervalsProvider.notifier).update((state) => currentCycle);
                      ref.read(secondsProvider.notifier).update((state) => secondsResult);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Results();
                          }
                      );
                    },
                    child: Icon(Icons.exit_to_app)
                )
              ],
            )
          ],
        );
  }
}
