import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/home_page.dart';
import 'ui/stats_page.dart';
import 'ui/stats_null_page.dart';
import "ui/showering_page.dart";

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => ColdShower(),
      child: const MainApp(),
    
));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.eye),
            label: "Statistics",
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return <Widget>[
          HomePage(),
          StatsPage(),
        ][index];
      }
    );
  }
}
