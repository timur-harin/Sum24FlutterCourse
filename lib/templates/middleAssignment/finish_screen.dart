import 'package:education/templates/middleAssignment/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/storage.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FinishScreen extends StatefulWidget {
  final ShowerSession currentSession;

  const FinishScreen({
    super.key,
    required this.currentSession,
  });

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  late String formattedDate;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('d MMMM, yyyy', 'en_US').format(widget.currentSession.date);
  }

  void _endSession() {
    setState(() {
      widget.currentSession.feedback = _feedbackController.text;
      LocalStorageService().updateLastSession(widget.currentSession);
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }
    
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Summary'),
        backgroundColor: const Color(0xFF24305E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Session Details", style: Theme.of(context).textTheme.titleLarge),
            TextFormField(
              controller: _feedbackController,
              decoration: const InputDecoration(
              labelText: 'Your Impressions',
              hintText: 'How was your session?',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            setState(() {
              _endSession();
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF24305E),
            foregroundColor: Colors.white,
          ),
          child: const Text('End Session'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}