import 'package:education/templates/middleAssignment/SessionOverview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secondsProvider = StateProvider<int?>((ref) => null);
final temperatureProvider = StateProvider<int?>((ref) => null);



class Newshower extends ConsumerStatefulWidget {
  const Newshower({super.key});

  @override
  ConsumerState<Newshower> createState() => _NewshowerState();
}

class _NewshowerState extends ConsumerState<Newshower> {
  int seconds = 60;
  int temperature = 15;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('New Seanse'),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('time'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: substractSeconds,
                child: Icon(Icons.remove),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '$seconds',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              ElevatedButton(
                onPressed: insertSeconds,
                child: Icon(Icons.add),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('temperature'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: substractTemp,
                child: Icon(Icons.remove),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '$temperature',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              ElevatedButton(
                onPressed: insertTemp,
                child: Icon(Icons.add),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: ElevatedButton(
                      onPressed: (){
                        ref.read(secondsProvider.notifier).update((state) => seconds);
                        ref.read(temperatureProvider.notifier).update((state) => temperature);
                        // Navigator.pushNamed(context, '/new/SessionOverview');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Sessionoverview();
                          }
                        );
                      },
                      child: Text('start')
                  ),
              )
            ]
          )
        ]
      ),
    );
  }
}

