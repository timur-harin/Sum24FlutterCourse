import 'dart:convert';
import 'session_preferences_screen.dart';
import 'session_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ShowerSession>> _previousSessions;
  bool _showAllSessions = false;

  @override
  void initState() {
    super.initState();
    _previousSessions = _getPreviousSessions();
  }

  Future<List<ShowerSession>> _getPreviousSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> sessionStrings = prefs.getStringList('sessions') ?? [];
    return sessionStrings.map((sessionString) {
      return ShowerSession.fromMap(jsonDecode(sessionString));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<ShowerSession> displayedSessions = [];
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'),
      body: FutureBuilder(
        future: _previousSessions,
        builder: (context, AsyncSnapshot<List<ShowerSession>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var sessions = snapshot.data!;
            displayedSessions = _showAllSessions
                ? sessions.reversed.toList()
                : sessions.reversed.take(5).toList();
            return Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SessionPreferencesScreen()));
                        setState(() {
                          _previousSessions = _getPreviousSessions();
                        });
                      },
                      width: 400,
                      height: 100,
                      text: 'Start New Session',
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      gradientColors:
                          Theme.of(context).brightness == Brightness.dark
                              ? [Colors.green, Colors.green.shade800]
                              : [Colors.green, Colors.green.shade300],
                    ),
                    const Padding(padding: EdgeInsets.all(2.0)),
                    GradientButton(
                      onPressed: () {
                        setState(() {
                          _showAllSessions = !_showAllSessions;
                        });
                      },
                      text: _showAllSessions
                          ? 'Hide sessions'
                          : 'Show all sessions',
                      gradientColors:
                          Theme.of(context).brightness == Brightness.dark
                              ? [Colors.grey, Colors.grey.shade800]
                              : [Colors.grey, Colors.grey.shade500],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: displayedSessions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(displayedSessions[index].name),
                          subtitle: Text(
                              'Duration: ${displayedSessions[index].overallDuration} seconds'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                  displayedSessions[index].rating as int,
                                  (index) => const Icon(Icons.star,
                                      color: Colors.yellow),
                                ) +
                                List.generate(
                                  5 - displayedSessions[index].rating as int,
                                  (index) => Icon(Icons.star,
                                      color: Colors.grey.shade300),
                                ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SessionDetailsScreen(
                                  session: displayedSessions[index],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
