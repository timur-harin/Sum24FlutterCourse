import 'dart:convert';
import 'dart:io';
import 'package:education/templates/middleAssignment/notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import  'package:intl/intl.dart';
import  'linepainter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerSession {
  String? date;
  bool hotStart;
  int intervalsNumber;
  int intervalsDuration;
  int? endTime;
  int? estimation;

  ShowerSession({this.date, required this.hotStart, required this.intervalsNumber, required this.intervalsDuration, this.endTime, this.estimation});

  void setEndTime(int time) {
    endTime = time;
  }

  void setDate() {
    DateTime now = DateTime.now();
    date = DateFormat('HH:mm dd.MM').format(now);
  }

  void setEstimation(int estimation) {
    this.estimation = estimation;
  }
}


class UserHistory {
  
  Future<void> saveSession ({required ShowerSession session}) async{
    final pref = await SharedPreferences.getInstance();
    int sessionsNumber = await pref.getInt('sessionsNumber') ?? 0;
    
    String key = sessionsNumber.toString();
    String json = jsonEncode({
      'date' : session.date,
      'hotStart': session.hotStart,
      'intervalsNumber': session.intervalsNumber,
      'intervalsDuration': session.intervalsDuration,
      'endTime':session.endTime,
      'estimation':session.estimation
      });
    pref.setString(key, json);
    pref.setInt('sessionsNumber', sessionsNumber+1);
  }

  void removeSession (int index) async {
    final pref = await SharedPreferences.getInstance();
    int sessionsNumber = await pref.getInt('sessionsNumber') ?? 0;
    if(index >= sessionsNumber || index < 0) {
      exit(-1);
    }
    for(int i = index; i < sessionsNumber-1; i++) {
      String json = await pref.getString((i+1).toString())!;
      pref.setString(i.toString(), json);
    }
    pref.remove((sessionsNumber-1).toString());
    pref.setInt('sessionsNumber', sessionsNumber-1);
  }

  void removeAllHistory() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();    
  }

  Future<ShowerSession> getSession (int index) async{
    final pref = await SharedPreferences.getInstance();
    int sessionsNumber = await pref.getInt('sessionsNumber') ?? 0;
    if(index >= sessionsNumber || index < 0) {
      exit(-1);
    }
    String json = await pref.getString(index.toString())!;
    var session = ShowerSession(
      date: jsonDecode(json)['date'],
      hotStart: jsonDecode(json)['hotStart'],
      intervalsNumber: jsonDecode(json)['intervalsNumber'],
      intervalsDuration: jsonDecode(json)['intervalsDuration'],
      endTime: jsonDecode(json)['endTime'],
      estimation: jsonDecode(json)['estimation']
    );
    return session;
  }


  Future<List<Widget>> getList() async {
    List<Widget> result = [];

    final pref = await SharedPreferences.getInstance();
    int sessionsNumber = pref.getInt('sessionsNumber') ?? 0;
    if (sessionsNumber == 0) {
      return result;
    }
    ShowerSession session;
    for (int i = 0; i < sessionsNumber; i++) {
      session = await getSession(i);
      result.add(SessionCard(index: i, session: session));
    }
    return result;
  }
}

class SessionCard extends ConsumerWidget {
  final int index;
  final ShowerSession session;
  const SessionCard({super.key, required this.index, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(session.date ?? ''),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5, (index){
                    return Icon(
                        index < session.estimation! ? Icons.star : Icons.star_border,
                        size: 40,
                        color: Colors.orange,
                      );
                  } ),)
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Intervals: ${session.intervalsNumber}'),
                      Text('Total time: ${((session.intervalsNumber*session.intervalsDuration)~/ 60).toString().padLeft(2, '0')}:${((session.intervalsNumber*session.intervalsDuration)% 60).toString().padLeft(2, '0')}')
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hot start: ${session.hotStart?"Yes":"No"}'),
                      if(session.endTime == session.intervalsDuration*session.intervalsNumber) 
                        Column(children: [
                          Text('End time: ${((session.endTime!)~/ 60).toString().padLeft(2, '0')}:${((session.endTime!)% 60).toString().padLeft(2, '0')}', style: const TextStyle(color:Colors.green)),
                          Text('Session Completed', style: const TextStyle(color:Colors.green)),
                        ],),
                      if(session.endTime != session.intervalsDuration*session.intervalsNumber)
                        Text('End time: ${((session.endTime!)~/ 60).toString().padLeft(2, '0')}:${((session.endTime!)% 60).toString().padLeft(2, '0')}'),
                    ],
                  ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ref.read(userHistoryProvider).removeSession(index);
                        ref.read(timeToReloadProvider.notifier).state = true;
                      },
                    )
                    
                  
                ],
              ),
              Center(
                    child: SizedBox(
                      width: 300,
                      height: 15,
                      child: CustomPaint(
                        painter: ColoredLinePainter(
                          numberOfSegments: session.intervalsNumber,
                          startWithRed: session.hotStart,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      );
  }
}