import 'package:flutter/material.dart';

import 'dart:async';

class Statistic extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      
      alignment: Alignment.center,
      width: 400,
      height: 533,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(20), // Add rounded corners
      ),
      child: Column(
        children: [
          Text('Statistic',style: TextStyle(color: Colors.white,fontSize: 20),),
          Row(
            children: [
              Spacer(),
              Text('Date ',style: TextStyle(color: Colors.white,fontSize: 20),),
              Spacer(),
              Text('Time ',style: TextStyle(color: Colors.white,fontSize: 20),),
              Spacer(),
              Text('Temperature', style: TextStyle(color: Colors.white,fontSize: 20),),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 400,
            width: 400,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('More', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
              ),
            ),
          ),
        ],
        ),
    );
  }
}