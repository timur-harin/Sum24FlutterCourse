import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'home_page_widget.dart';

class SessionOverviewPage extends StatelessWidget {
  final String sessionData;
  final int redBackgroundTime;
  final int blueBackgroundTime;
  final String sessionDate;

  const SessionOverviewPage({
    Key? key,
    required this.sessionData,
    required this.redBackgroundTime,
    required this.blueBackgroundTime,
    required this.sessionDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        automaticallyImplyLeading: true,
        title: Text(
          'Contrast Shower Session Overview',
          style: GoogleFonts.getFont(
            'Lexend',
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              color: Colors.grey.shade300,
              child: Text(
                'Date: $sessionDate',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lexend',
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              width: 400,
              color: Colors.grey.shade300,
              child: Text(
                'Session Data: $sessionData',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lexend',
                  color: Colors.black45,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              width: 400,
              color: Colors.redAccent.shade100,
              child: Text(
                'Hot temperature Time: $redBackgroundTime seconds',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lexend',
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              width: 400,
              color: Colors.blueAccent.shade100,
              child: Text(
                'Cold temperature Time: $blueBackgroundTime seconds',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lexend',
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePageWidget()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'Back to Home',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lexend',
                  color: Colors.black54,
                  fontSize: 48,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
