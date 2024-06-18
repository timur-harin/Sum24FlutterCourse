import 'package:education/templates/middleAssignment/homePage_screen.dart';
import 'package:flutter/material.dart';

class SessionSummaryScreen extends StatelessWidget {
  final int totalTime;
  final int totalPhases;

  SessionSummaryScreen({required this.totalTime, required this.totalPhases});

  @override
  Widget build(BuildContext context) {
    int totalMinutes = totalTime ~/ 60;

    return Scaffold(
      backgroundColor: Color.fromRGBO(157, 213, 235, 1), // Background color of the screen
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Session Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity, // Full width container
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white, // Box background color
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Time: $totalMinutes mins',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total Phases: $totalPhases',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomepageScreen(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 240, 240, 240)),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Text('Done', style: TextStyle(color: Colors.black),),
                        
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40), 
                Text(
                  'You did great today! Keep it up!',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
