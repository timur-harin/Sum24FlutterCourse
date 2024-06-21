import 'package:education/templates/middleAssignment/ShowerProcess.dart';
import 'package:education/templates/middleAssignment/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/newShower.dart';





class Results extends ConsumerStatefulWidget {
  const Results({super.key});

  @override
  ConsumerState<Results> createState() => _ResultsState();
}

class _ResultsState extends ConsumerState<Results> {

  @override
  Widget build(BuildContext context) {
    final temp = ref.read(temperatureProvider) ?? 15;
    final seconds = ref.read(secondsProvider) ?? 60;
    final intervals = ref.read(IntervalsProvider) ?? 1;
    final sessionList = ref.watch(sessionListProvider);
    return AlertDialog(
      title: const Text('Session Results'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('time:'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('$seconds'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('temperature:'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('$temp'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Number of intervals:'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('$intervals'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              Padding(
                padding: EdgeInsets.symmetric(vertical : 10 , horizontal: 20),
                child:
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text('delete')
                  ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical : 10, horizontal: 20),
                  child:
                    ElevatedButton(
                        onPressed: (){
                          var session = Session(time: seconds, intervals: intervals, temperature: temp);
                          ref.read(sessionListProvider.notifier).addSession(session);
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text('save')
                    ),
              )
            ],
          )
        ],
      ),

    );
  }
}
