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

  @override
  void initState() {
    super.initState();
    _previousSessions = _getPreviousSessions();
  }

  Future<List<ShowerSession>> _getPreviousSessions() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> sessionStrings = prefs.getStringList('sessions') ?? [];
  List<ShowerSession> allSessions = sessionStrings.map((sessionString) {
    return ShowerSession.fromMap(jsonDecode(sessionString));
  }).toList();
  int start = allSessions.length > 5 ? allSessions.length - 5 : 0;
  return allSessions.sublist(start, allSessions.length).reversed.toList();
}

  @override
  Widget build(BuildContext context) {
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(
                        'Duration: ${snapshot.data![index].overallDuration} seconds'),
                    // Display overallDuration here
                    trailing: Text('Rating: ${snapshot.data![index].rating}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionDetailsScreen(
                            session: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: GradientButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SessionPreferencesScreen()));
          setState(() {
            _previousSessions = _getPreviousSessions();
          });
        },
        text: 'Start New Session',
        gradientColors: [Colors.green, Colors.green.shade300],
      ),
    );
  }
}
