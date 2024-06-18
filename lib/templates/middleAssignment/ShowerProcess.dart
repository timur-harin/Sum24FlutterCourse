import 'package:education/templates/middleAssignment/newShower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/SessionResults.dart';
import 'dart:async';

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
  late Timer timer;
  int currentCycle = 0;
  int cnt = 0;

  void startTimer(int NumOfCycles, int NumInCycle) {
    timeLeft = NumInCycle;
    final cycles = NumOfCycles;
    const oneSec = Duration(seconds: 1);

    timer = new Timer.periodic(
        oneSec,
            (Timer timer){
          if (timeLeft == 0){
            if (cycles > 0){
              setState(() {
                timer.cancel();
              });
              print('1');
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
    );
    isRunning = true;
  }

  void pauseTimer() {
    if (!isRunning) return;
    timer.cancel();
    isRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    final seconds = ref.read(secondsProvider);
    if (seconds == null){
      ref.read(secondsProvider.notifier).update((state) => 60);
    }
    NumOfCycles = (seconds! / 10).round();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
          title: const Text('Shower'),
        ),
        body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('$currentCycle / $NumOfCycles '),
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
                  child: Text('$timeLeft'),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:
                    ElevatedButton(
                        onPressed: (){
                          if (cnt == 0){
                            cnt++;
                            startTimer(NumOfCycles!, 10);
                          }
                          else{
                            startTimer(NumOfCycles!, timeLeft);
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
        )
    );
  }
}
