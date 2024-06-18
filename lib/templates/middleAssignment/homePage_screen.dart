// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'preferences_screen.dart';
import 'session_history_screen.dart';
import 'library_screen.dart';
import 'session_history_provider.dart';

class HomepageScreen extends ConsumerStatefulWidget {
  const HomepageScreen({super.key});

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends ConsumerState<HomepageScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeContent(),
    SessionHistoryScreen(),
    LibraryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
          
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Sessions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: ClipPath(
            clipper: AsymmetricShapeClipper(),
            child: Container(
              color: Color.fromRGBO(157, 213, 235, 1),
              child: Center(
                child: Text(
                  "Be a better version of yourself",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencesScreen(),
                ),
              );
            },
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "Start New Session",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ClipPath(
            clipper: WavyShapeClipper(),
          child: Container(
            color: Color.fromRGBO(157, 213, 235, 1),
            child: Center(
            child:
            Column(
              children: [
                Text(" "),
                Text(" "),
                Text(" "),
                if (sessionHistory.isNotEmpty) ...[
                  SizedBox(height: 20),
                  Text(
                    "Last Session:",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    "Total Time: ${sessionHistory.last.totalTime ~/ 60} mins",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    "Total Phases: ${sessionHistory.last.totalPhases}",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ],
            ),
            ),
          ),
          ),
        ),
      ],
    );
  }
}

class WavyShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.2); // Start at the upper-left corner
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.1, size.width * 0.5, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.3, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height); // Straight line to the bottom-right corner
    path.lineTo(0, size.height); // Line back to the bottom-left corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}



class AsymmetricShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.6, size.width, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.7, size.width, size.height * 0.9);
    path.quadraticBezierTo(size.width , size.height * 0.8, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
