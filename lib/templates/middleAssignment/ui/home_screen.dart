import 'dart:convert';

import 'package:education/templates/middleAssignment/data/providers/session_history.dart';
import 'package:education/templates/middleAssignment/ui/session_preferences_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late Future<List<SessionHistory>> futureSessionHistory;

  @override
  void initState() {
    super.initState();
    futureSessionHistory = getSessionHistoryData();
  }

  Future<List<SessionHistory>> getSessionHistoryData() async {
    var prefs = await SharedPreferences.getInstance();
    final encodedHistoryList = prefs.getStringList('sessionHistoryData');

    if (encodedHistoryList == null) return [];

    final historyList = encodedHistoryList.map((encodedHistory) {
      final decodedHistory = json.decode(encodedHistory);
      return SessionHistory.fromJson(decodedHistory);
    }).toList();

    return historyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contrast Shower Companion')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Contrast Shower Companion'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SessionPreferencesScreen()),
                );
              },
              child: Text('Start New Session'),
            ),
            SizedBox(height: 20),
            Text('Session History:'),
            SizedBox(
              height: 500,
              child: FutureBuilder(
                future: futureSessionHistory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return const Text('Ошибка при загрузке истории');
                  } else {
                    final sessionHistoryList = snapshot.data!.reversed.toList();

                    return ListView.builder(
                      itemCount: sessionHistoryList.length,
                      itemBuilder: (context, index) {
                        final sessionHistory = sessionHistoryList[index];
                        return GestureDetector(
                          child: Container(
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.all(20),
                              height: 85,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 118, 255, 123),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          'Total time: ${sessionHistory.time} min'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          'Count of phases: ${sessionHistory.countOfPhases}'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Rating: ${sessionHistory.rating}'),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
