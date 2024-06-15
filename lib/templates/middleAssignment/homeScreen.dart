import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'StartNewCycleTab.dart';
import 'SettingsTab.dart';
import 'HistoryTab.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  final tabs = [
    CycleTab().newCycle(),
    HistoryTab().tab(),
    SettingsTab().tab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Contrast Shower Manager",
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shower_outlined,
              color: Colors.white,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon (
              Icons.list_alt_outlined,
              color: Colors.white,
            ),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: "Settings"
          )
        ],
        backgroundColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      )
    );
  }
}