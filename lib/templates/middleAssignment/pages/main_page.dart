import 'package:flutter/material.dart';
import '../data/session.dart';
import '../providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   List<Session> sessions = [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  _loadSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sessions = (json.decode(prefs.getString('sessions') ?? '[]') as List)
          .map((sessionJson) => Session.fromJson(sessionJson))
          .toList();
    });
  }
  
  _saveSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessions', json.encode(sessions));
  }

  
  // final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  // late Future<List<Session>> futureSessionData;

  // @override
  // void initState() {
  //   super.initState();
  //   futureSessionData = getSessionData();
  // }

  // Future<List<Session>> getSessionData() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   final encodeSessionList = prefs.getStringList('sessionData');
  //   if (encodeSessionList == null) {
  //     return [];
  //   }
  //   final sessionList = encodeSessionList.map((encodeSession){
  //     final decodeSession = json.decode(encodeSession);
  //     return Session.fromJson(decodeSession);
  //   }).toList();
  //   return sessionList;
  // }

  IconData getIcon(SessionType type) {
    switch (type) {
      case SessionType.Excellent:
        return Icons.favorite;
      case SessionType.Good:
        return Icons.emoji_emotions;
      case SessionType.Neutral:
        return Icons.face;
      case SessionType.Bad:
        return Icons.face_5;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final sessionProvider = Provider.of<SessionProvider>(context);

    // initState();
    // sessionProvider.sessions = futureSessionData as List<Session>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Shower'),
        backgroundColor: const Color.fromARGB(255, 194, 239, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 194, 239, 245),
      body: Center(
        child: FutureBuilder (
          future: sessionProvider.sessions.isEmpty ? Future.value(sessions) : Future.value(sessionProvider.sessions), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.data == null) {
              return const Text('No data');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      for (Session session in sessionProvider.sessions)
                        Container(
                          width: 800,
                          height: 30,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: session.color == 'Hot' ? const Color.fromARGB(255, 232, 145, 139) : const Color.fromRGBO(100, 170, 228, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(flex: 1, child: Icon(getIcon(session.feedback))),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(flex: 2, child: Align(
                                alignment: Alignment.center,
                                child: Text("Srart: " + session.color))),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(flex: 2, child: Align(
                                alignment: Alignment.center,
                                child: Text("Total time: " + session.duration.toString() + " sec"))),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(flex: 2, child: Align(
                                alignment: Alignment.center,
                                child: Text("№ of cycles: " + session.numOfCycles.toString()))),
                            ],
                          ),
                        )
                    ],
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child:  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 235, 255, 119)), 
                        textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(fontSize: 20)),
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                        ),
                      onPressed: () {
                        // if (sessions.length == sessionProvider.sessions.length) {
                        //   sessions = sessionProvider.sessions;
                        //   _saveSessions();
                        // }
                        // if (sessionProvider.sessions.isNotEmpty && sessionProvider.sessions.last != sessions.last) {
                        //   sessions.add(sessionProvider.sessions.last);
                        // _saveSessions();
                        // }
                        Navigator.of(context).pushNamed('/settings');
                      },
                      child: Text('New session'),
                    ),
                  )
                ],
              );
            }
          },
        )
      ),
    );
  }
}
