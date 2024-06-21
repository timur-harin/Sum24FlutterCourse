import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'activesession.dart';

class SessionPreferencesScreen extends StatefulWidget{
  const SessionPreferencesScreen({super.key});

  @override
  _SessionPreferencesScreenState createState() => _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen>{
  final _durationController = TextEditingController(text: '5');
  final _intervalController = TextEditingController(text: '12');
  final _hotTempController = TextEditingController(text: '12');
  final _coldTempController = TextEditingController(text: '12');

  @override
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        centerTitle: true,
        title: const Text('Session preference'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select the session duration in minutes',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _durationController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Select the maximum cold water temperature in degrees',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _coldTempController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Select the maximum temperature of warm water in degrees',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _hotTempController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Select the interval between temperature changes in seconds',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _intervalController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                 
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.teal, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                final duration = int.parse(_durationController.text);
                final interval = int.parse(_intervalController.text);
                final coldTemp = int.parse(_coldTempController.text);
                final hotTemp = int.parse(_hotTempController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      duration: duration,
                      interval: interval,
                      coldTemp: coldTemp,
                      hotTemp: hotTemp,
                    ),
                  ),
                );
              },
              child: const Text(
                'Start session',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
