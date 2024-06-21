import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/Storage/ShowerHistory.dart';
import 'package:education/templates/middleAssignment/Storage/SharedPreferenciesServise.dart';


class Statistic extends StatelessWidget {
  final Future<List<ShowerHistory>> showerHistories;

  Statistic({required this.showerHistories});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text('Statistic', style: TextStyle(color: Colors.white, fontSize: 20)),
          Row(
            children: [
              Spacer(),
              Text('Date', style: TextStyle(color: Colors.white, fontSize: 20)),
              Spacer(),
              Text('Name', style: TextStyle(color: Colors.white, fontSize: 20)),
              Spacer(),
              Text('Time', style: TextStyle(color: Colors.white, fontSize: 20)),
              Spacer(),
            ],
          ),
          FutureBuilder<List<ShowerHistory>>(
            future: showerHistories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No data available', style: TextStyle(color: Colors.white));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final history = snapshot.data![index];
                      return Row(
                        children: [
                          Spacer(),
                          Text(
                            '${history.date.day}/${history.date.month}/${history.date.year}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            history.notes, // Assuming 'notes' contains the 'name' for this example
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            '${(history.duration ~/ 60).toString().padLeft(2, '0')}:${(history.duration % 60).toString().padLeft(2, '0')}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Spacer(),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('More', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  late Future<List<ShowerHistory>> _showerHistoriesFuture;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void initState() {
    super.initState();
    _showerHistoriesFuture = _sharedPreferencesService.getShowerHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shower Statistics'),
      ),
      body: FutureBuilder<List<ShowerHistory>>(
        future: _showerHistoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Statistic(showerHistories: _showerHistoriesFuture);
          }
        },
      ),
    );
  }
}
