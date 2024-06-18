import 'package:education/templates/middleAssignment/TimerScreen2.dart';
import 'package:flutter/material.dart';
class ScreenLike extends StatefulWidget{
  const ScreenLike({super.key});

  @override
    State<ScreenLike> createState() => _ScreenLikeState();
  
}
class _ScreenLikeState extends State<ScreenLike> {
  int _rating = 0;
  String str='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
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
              i <= _rating ? Icons.star : Icons.star_border,
              color: i <= _rating ? Colors.yellow : Colors.grey,
            ),
          ),
          ],
        ),
          Text('Параметры текущего сеанса:'),
          Text('Вы находились в душе $time2 секунд из $time3 секунд'),
          Text('Холодных периодов : $ColdCount'),
          Text('Горячих периодов : $HotCount'),
          
      ],
      
   )
    )
    );
  }
}
