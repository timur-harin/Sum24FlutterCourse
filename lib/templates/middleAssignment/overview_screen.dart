import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/storage.dart';
import 'package:education/templates/middleAssignment/timer_screen.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SessionDetailsScreen extends StatefulWidget {
  final List<ShowerPhase> phases;
  final DateTime sessionDate;

  const SessionDetailsScreen({
    super.key,
    required this.phases,
    required this.sessionDate,
  });

  @override
  _SessionDetailsScreenState createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  bool _isSaved = false;
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('d MMMM, yyyy', 'en_US').format(widget.sessionDate);
  }

  void _saveSession(BuildContext context) async {
    if (widget.phases.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              color: Color(0xFF24305E),
            ),  
          ),
          content: const Text(
            'Please add at least one phase before saving the session.',
            style: TextStyle(
              color: Color(0xFF24305E),
            ),  
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF24305E),
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    try {
      ShowerSession session = ShowerSession(date: widget.sessionDate, phases: widget.phases);

      LocalStorageService localStorageService = LocalStorageService();
      List<ShowerSession> sessions = await localStorageService.getSessions();
      sessions.add(session);
      await localStorageService.saveSessions(sessions);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Success',
            style: TextStyle(
              color: Color(0xFF24305E),
            ),
          ),
          content: const Text(
            'The session has been saved successfully.',
            style: TextStyle(
              color: Color(0xFF24305E),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF24305E),
                ),
              ),
            ),
          ],
        ),
      );
      
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              color: Color(0xFF24305E),
            ),
          ),
          content: Text(
            'Failed to save the session: $e',
            style: const TextStyle(
              color: Color(0xFF24305E),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF24305E),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Details'),
        backgroundColor: const Color(0xFF24305E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: $formattedDate',
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF374785),
                ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.phases.length,
                      itemBuilder: (context, index) {
                        final phase = widget.phases[index];
                        return ListTile(
                          title: Text(
                            phase.name,
                            style: TextStyle(
                              color: phase.name == 'hot'
                                  ? const Color.fromARGB(255, 155, 36, 36)
                                  : const Color(0xFF374785),
                            ),
                          ),
                          subtitle: Text('Duration: ${phase.duration.inMinutes} minutes'),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Total Time:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF374785),
                      ),
                    ),
                    subtitle: Text(
                      '${widget.phases.fold<int>(0, (previousValue, element) => previousValue + element.duration.inMinutes)} minutes',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF374785),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: ElevatedButton(
                  onPressed: () {
                    _saveSession(context);
                    setState(() {
                      _isSaved = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF24305E)),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('Save Session'),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_isSaved) {
            showDialog(
              context: context, 
              builder: (BuildContext) {
                return AlertDialog(
                  title: const Text("Session is not saved"),
                  content: const Text("Please save the session before starting the timer"),
                  actions: <Widget> [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                );
              }
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TimerScreen(phases: widget.phases, sessionDate: widget.sessionDate)),
            );
          }
        },
        backgroundColor: const Color(0xFF24305E),
        foregroundColor: Colors.white,
        child: const Icon(Icons.timer),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}