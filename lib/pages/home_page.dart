import 'package:contrast_shower_app/globaL/const.dart';
import 'package:contrast_shower_app/pages/history_page.dart';
import 'package:contrast_shower_app/pages/timer_settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List pages = [
    const TimerSettingsPage(),
    const HistoryPage(),
  ];
  int _selectedindex = 0;

   void _onItemTapped(int index){
    setState(() {
      _selectedindex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedindex,
        backgroundColor: dark1,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer,color: white),
            label: 'Таймер'
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,color: white,),
            label:'История'
          )
        ]
    ),
    );
  }
}