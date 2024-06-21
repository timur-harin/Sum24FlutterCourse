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
      width: 300,
      height: 400,
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
                  Text('Date', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('Name', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('Time', style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            SizedBox(
              height: 2,
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
                      shrinkWrap: true, // Use shrinkWrap to avoid unbounded height
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final history = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${history.date.day}/${history.date.month}/${history.date.year}',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                history.name,
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                '${(history.duration ~/ 60).toString().padLeft(2, '0')}:${(history.duration % 60).toString().padLeft(2, '0')}',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text('More', style: TextStyle(color: Colors.white)),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
