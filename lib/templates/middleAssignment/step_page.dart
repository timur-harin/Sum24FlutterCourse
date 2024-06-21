import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page_widget.dart';

class StepPage extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onNextPressed;
  final VoidCallback onPrevPressed;
  final VoidCallback onFinishPressed; // New callback for finish action
  final bool isLastStep;

  StepPage({
    required this.title,
    required this.content,
    required this.onNextPressed,
    required this.onPrevPressed,
    required this.onFinishPressed,
    this.isLastStep = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        automaticallyImplyLeading: true,
        title: Text(
          'ContrastApp',
          style: GoogleFonts.getFont(
            'Lexend',
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.black87,
            onPressed: () {
              // Define the action for the Home button here
              // For example, navigate to the home page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePageWidget()),
                    (Route<dynamic> route) => false, // Removes all routes below this one
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 52.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Text(
                          content,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 36.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!isLastStep) // Show Prev and Next buttons if not the last step
                  Expanded(
                    child: TextButton(
                      onPressed: onPrevPressed,
                      child: Text(
                        'Prev',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Lexend',
                          color: Colors.black,
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ),
                SizedBox(width: 0.0), // Optional spacing between buttons
                if (!isLastStep)
                  Expanded(
                    child: TextButton(
                      onPressed: onNextPressed,
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Lexend',
                          color: Colors.black,
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ),
                if (isLastStep) // Show Finish Guide button if it's the last step
                  Expanded(
                    child: TextButton(
                      onPressed: onFinishPressed,
                      child: Text(
                        'Finish Guide',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Lexend',
                          color: Colors.black,
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
