import 'dart:convert';

import 'package:education/templates/middleAssignment/TimerScreen2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screen2.dart';

class ScreenLike extends StatefulWidget {
  final int time2;
  final int time3;
  final int ColdCount;
  final int HotCount;

  const ScreenLike({super.key, required this.time2, required this.time3, required this.ColdCount, required this.HotCount});

  @override
  State<ScreenLike> createState() => _ScreenLikeState();
}

class _ScreenLikeState extends State<ScreenLike> {
  int _rating = 0;
  String str = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Оцените сеанс'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Оцените сеанс:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = i;
                      });
                    },
                    child: Icon(
                      i <= _rating? Icons.star : Icons.star_border,
                      color: i <= _rating? Colors.yellow : Colors.grey,
                    ),
                  ),
              ],
            ),
            Text('Параметры текущего сеанса:'),
            Text('Вы находились в душе $time2 секунд из $time3 секунд'),
            Text('Холодных периодов : $ColdCount'),
            Text('Горячих периодов : $HotCount'),
            SizedBox(height: 20),
           ElevatedButton(
  onPressed: () async {
    final session = Session(
      time2: widget.time2,
      time3: widget.time3,
      coldCount: widget.ColdCount,
      hotCount: widget.HotCount,
      rating: _rating,
    );
    final prefs = await SharedPreferences.getInstance();
    final sessions = prefs.getStringList('sessions') ?? [];
    final jsonString = jsonEncode(session.toMap());
    sessions.add(jsonString);
    await prefs.setStringList('sessions', sessions);
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => Screen2()),
    );
  },
  child: Text('Сохранить'),
),
          ],
        ),
      ),
    );
  }
  
}
//