import 'package:education/templates/middleAssignment/models/provider/provider.dart';
import 'package:education/templates/middleAssignment/models/shower_session.dart';
import 'package:education/templates/middleAssignment/screens/session_screen.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/services/storage_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // late Future<List<ShowerSession>> _showerSessionsFuture;

  List<ShowerSession> sessions = [];

@override 
  void initState() { 
    super.initState(); 
    _loadSessionsData(); 
  } 
 
  Future<void> _loadSessionsData() async { 
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    List<String>? sessionsJson = prefs.getStringList('sessions'); 
    if (sessionsJson != null) { 
      setState(() { 
        sessions = sessionsJson 
            .map((session) => ShowerSession.fromJson(session)) 
            .toList(); 
      }); 
    } 
  }
  @override
  Widget build(BuildContext context) {
    final sessions = ref.watch(valueProvider);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('Home Screen', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 36, 84, 35)),),
          Icon(Icons.bathtub, size: 80, color: Color.fromARGB(255, 90, 163, 88)),
          Expanded(
            child: Center(
              child: Text('Let\'s start your new shower session!', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 36, 84, 35)),),
            ),
          ),

          Expanded(
            child: 
            
            // FutureBuilder<List<ShowerSession>>(
            //   future: _showerSessionsFuture,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator(); 
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else if (snapshot.hasData || true) {
                   ListView.builder(
                    itemCount: sessions.sessions.length,
                    itemBuilder: (context, index) {
                      final session = sessions.sessions[index];
                      return Row(children: [
                        Text('${session.totalDuration} min'),
                        Text('Rate: ${session.rate}'),
                        Text('Cycles: ${session.numbOfCycles}'),
                    ],);
                      
                    },
                  ),),]),
      //           } else {
      //             return Text('No sessions found.');
      //           }
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/shower')  ;    },
        child: Icon(Icons.add),
        tooltip: 'Start New Session',
      ),
    );
  }
}