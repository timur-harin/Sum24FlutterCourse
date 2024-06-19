import 'package:education/templates/middleAssignment/screens/history.dart';
import 'package:education/templates/middleAssignment/screens/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() {
  Hive.initFlutter();
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

const MaterialColor primary = Colors.teal;
const MaterialAccentColor accent = Colors.tealAccent;

class MiddleAssigmentApp extends StatefulWidget {
  const MiddleAssigmentApp({super.key});

  @override
  State<StatefulWidget> createState() => _MiddleAssignmentAppState();
}

class _MiddleAssignmentAppState extends State<MiddleAssigmentApp> {
  int _index = 0;
  static const List<Widget> _screens = [
    ShowerSessionScreen(),
    SessionHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: primary,
      ),
      // TODO - complete assignment
      home: Scaffold(appBar: AppBar(leading: IconButton(icon: const
      Icon(Icons.meeting_room), onPressed: () {
        Hive.close();
        SystemNavigator.pop();
      })),
        body: _screens[_index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.shower), label: 'Session'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'History'),
          ],
        ),
      ),
    );
  }
}
