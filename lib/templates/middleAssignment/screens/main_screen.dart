import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shower_companion/models/shower_session.dart';
import 'create_session_screen.dart';
import 'package:shower_companion/providers/shower_session_provider.dart';
import 'package:intl/intl.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String currentDate = DateFormat('MMMM d, EEEE').format(DateTime.now());

    final sessions = ref.watch(showerSessionProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Expanded(
                flex: 70,
                child: Center(child: Text('Contrast Shower Companion',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),)),
              ),
              Expanded(
                flex: 70,
                child: Center(child: Text(currentDate ,style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20),)),
              ),
              
              SessionListWidget(sessions: sessions),
              const CreateSessionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SessionListWidget extends StatelessWidget {
  const SessionListWidget({
    super.key,
    required this.sessions,
  });

  final List<ShowerSession> sessions;

  @override
  Widget build(BuildContext context) {
    final reversedSessions = sessions.reversed.toList();

    return Expanded(
      flex: 590,
      child: ListView.builder(
        itemCount: reversedSessions.length,
        itemBuilder: (context, index) {
          final session = reversedSessions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        session.date,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total Duration: ${session.totalDuration.inMinutes} minutes',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CreateSessionWidget extends StatelessWidget {
  const CreateSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      flex: 160,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, -7),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 250,
              child: Container(
                color: Colors.white,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('Start a new session', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Text('press the button and customize your contrast shower experience', style: TextStyle(color: Color.fromRGBO(100, 100, 100, 1), fontSize: 15)),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 180,
              child: Container(
                color: Colors.white,
                child: IconButton(
                  icon: Image.asset('assets/images/shower_icon.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateSessionScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}