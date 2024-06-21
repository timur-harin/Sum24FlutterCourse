import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'counter_timer.dart';
import 'guide.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<String> sessions = [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sessions = prefs.getStringList('sessions') ?? [];
      sessions = sessions.reversed.toList();
    });
  }

  void _navigateToCounterPage() async {
    final sessionDuration = await Navigator.push<int?>(
      context,
      MaterialPageRoute(
        builder: (context) => const CounterPage(),
      ),
    );

    if (sessionDuration != null) {
      _addSession('Session duration: $sessionDuration seconds');
    }
  }

  void _addSession(String sessionData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedSessions = prefs.getStringList('sessions') ?? [];
    updatedSessions.add(sessionData);
    await prefs.setStringList('sessions', updatedSessions);
    setState(() {
      sessions = updatedSessions;
    });
  }

  void _deleteSession(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedSessions = prefs.getStringList('sessions') ?? [];
    updatedSessions.removeAt(index);
    await prefs.setStringList('sessions', updatedSessions);
    setState(() {
      sessions = updatedSessions;
    });
  }

  void _navigateToGuidePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContrastShowerGuideController(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
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
            icon: Icon(Icons.question_mark),
            color: Colors.black87,
            onPressed: () {
              // Define the action for the Home button here
              // For example, navigate to the home page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContrastShowerGuideController()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            sessions.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'There are no contrast shower sessions yet.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Lexend',
                        color: Colors.black45,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _navigateToGuidePage,
                      child: Text(
                        'Go to Guide',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Lexend',
                          color: Colors.black,
                          fontSize: 48,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                  child: Container(
                    width: 100,
                    height: 193,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text(
                                'Session #${sessions.length - index}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Lexend',
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2.0),
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Text(
                                  sessions[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    'Lexend',
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 24,
                            ),
                            onPressed: () {
                              _deleteSession(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 64, // Adjust the height as needed
          child: ElevatedButton(
            onPressed: _navigateToCounterPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.shade100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16), // Adjust top radius as needed
                ),
              ),
            ),
            child: Text(
              'Start new session',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Lexend',
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
