import 'package:education/templates/middleAssignment/SessionOverview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ShowerProcess.dart';

final secondsProvider = StateProvider<int?>((ref) => null);
final temperatureProvider = StateProvider<int?>((ref) => null);
final IntervalsProvider = StateProvider<int?>((ref) => null);

class Newshower extends ConsumerStatefulWidget {
  const Newshower({super.key});

  @override
  ConsumerState<Newshower> createState() => _NewshowerState();
}

class _NewshowerState extends ConsumerState<Newshower> {
  int seconds = 10;
  int temperature = 15;
  int numOfIntervals = 1;

  void substractIntervals () {
    setState(() {
      if (numOfIntervals > 1) {
        numOfIntervals--;
      }
    });
  }

  void addIntervals() {
    setState(() {
      numOfIntervals++;
    });
  }

  void insertIntervals() {
    setState(() {
      numOfIntervals++;
    });
  }

  void substractSeconds () {
    setState(() {
      if (seconds > 0) {
        seconds = seconds - 10;
      }
    });
  }
  void insertSeconds() {
    setState(() {
      seconds = seconds + 10;
    });
  }
  void substractTemp () {
    setState(() {
      if (temperature > 0) {
        temperature--;
      }
    });
  }
  void insertTemp() {
    setState(() {
      temperature++;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Анимация заднего фона
    var animatedBackground = AnimatedContainer(
      duration: Duration(seconds: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.8),
            Colors.red.withOpacity(0.8),
          ],
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('New Seanse', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          animatedBackground,
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Number of intervals', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: substractIntervals,
                        child: Icon(Icons.remove),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '$numOfIntervals',
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: addIntervals,
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Time of Interval', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: substractSeconds,
                        child: Icon(Icons.remove),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '$seconds',
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: insertSeconds,
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Temperature', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: substractTemp,
                        child: Icon(Icons.remove),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '$temperature',
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: insertTemp,
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: ElevatedButton(
                      onPressed: (){
                        ref.read(secondsProvider.notifier).update((state) => seconds);
                        ref.read(temperatureProvider.notifier).update((state) => temperature);
                        ref.read(IntervalsProvider.notifier).update((state) => numOfIntervals);

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Sessionoverview();
                            }
                        );
                      },
                      child: Text('Start', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
