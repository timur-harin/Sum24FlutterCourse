import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  late Future<List<Session>> _sessionsFuture;

  @override
  void initState() {
    super.initState();
    _sessionsFuture = _loadSessions();
  }

  Future<List<Session>> _loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessions = prefs.getStringList('sessions');
    if (sessions != null) {
      return sessions.map((jsonString) {
        final jsonMap = jsonDecode(jsonString);
        return Session(
          time2: jsonMap['time2'],
          time3: jsonMap['time3'],
          coldCount: jsonMap['coldCount'],
          hotCount: jsonMap['hotCount'],
          rating: jsonMap['rating'],
        );
      }).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' История:'),
      ),
      body: FutureBuilder(
        future: _sessionsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final sessions = snapshot.data as List<Session>;
            return ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return ListTile(
                  title: Text('Сессия ${session.rating}'),
                  subtitle: Text('Время в душе: ${session.time2} секунд\n'
                      'Планируемое время : ${session.time3} секунд\n'
                      'Хол периоды: ${session.coldCount}\n'
                      'Гор периоды: ${session.hotCount}'),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
//
class Session {
  final int time2;
  final int time3;
  final int coldCount;
  final int hotCount;
  final int rating;

  Session({required this.time2, required this.time3, required this.coldCount, required this.hotCount, required this.rating});

  Map<String, dynamic> toMap() {
    return {
      'time2': time2,
      'time3': time3,
      'coldCount': coldCount,
      'hotCount': hotCount,
      'rating': rating,
    };
  }
}