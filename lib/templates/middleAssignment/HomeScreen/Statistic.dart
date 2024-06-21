import 'package:education/templates/middleAssignment/HomeScreen/StatisticInfo.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/Storage/ShowerHistory.dart';
import 'package:education/templates/middleAssignment/Storage/SharedPreferencesService.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  late Future<List<ShowerHistory>> _showerHistoriesFuture;
  late SharedPreferencesService _sharedPreferencesService;

  @override
  void initState() {
    super.initState();
    _sharedPreferencesService = SharedPreferencesService();
    _showerHistoriesFuture = _sharedPreferencesService.getShowerSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDD0), // Background color
      body: FutureBuilder<List<ShowerHistory>>(
        future: _showerHistoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(
              child: Statistic(showerHistories: _showerHistoriesFuture),
            );
          }
        },
      ),
    );
  }
}

class Statistic extends StatelessWidget {
  final Future<List<ShowerHistory>> showerHistories;

  Statistic({required this.showerHistories});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 520,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Text('Statistic', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  Text('Date', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Spacer(),
                  Text('Name', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Spacer(),
                  Text('Time', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 240,
              child: FutureBuilder<List<ShowerHistory>>(
                future: showerHistories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var history;
                        if (snapshot.data!.length - 1 - index < 0) {
                          history = snapshot.data![0];
                        } else {
                          history = snapshot.data![snapshot.data!.length - 1 - index];
                        }
                        return GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Statisticinfo(
                                    name: history.name,
                                    time: Duration(seconds: history.duration),
                                    sessions: history.sessions,
                                    notes: history.notes,
                                    temperature: history.temperature,
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Container(
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.blue[700],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  Text(
                                    '${history.date.day}/${history.date.month}/${history.date.year}',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text(
                                    history.name,
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${(history.duration ~/ 60).toString().padLeft(2, '0')}:${(history.duration % 60).toString().padLeft(2, '0')}',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            )
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
              
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Handle button press
            //     },
            //     child: Text('More', style: TextStyle(color: Colors.white)),

            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.blue[700],
                  
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
