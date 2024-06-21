import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'starRating.dart';
import 'homeScreen.dart';

class SummaryScreen extends StatefulWidget {
  final String sessionData;

  SummaryScreen({required this.sessionData});

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int _rating = 0;

  void _onRatingChanged(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Session Overview:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                widget.sessionData,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 40),
              Text(
                'Rate this session:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              StarRating(initialRating: _rating, onRatingChanged: _onRatingChanged),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(sessionData: widget.sessionData, rating: _rating),
                    ),
                  );
                },
                child: Text('Return to Home Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
