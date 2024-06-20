import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models.dart';
import 'newSession_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your last sessions',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Color.fromARGB(255, 49, 50, 51),
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black45,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: Hive.box<ShowerSession>('sessions').listenable(),
                      builder: (context, Box<ShowerSession> box, _) {
                        if (box.values.isEmpty) {
                          return Center(
                            child: Text(
                              'No sessions yet.',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          );
                        }

                        final sessions = box.values.toList().reversed.toList(); 

                        return ListView.builder(
                          itemCount: sessions.length,
                          itemBuilder: (context, index) {
                            final session = sessions[index];
                            return Card(
                              color: Colors.white.withOpacity(0.9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              elevation: 5,
                              child: ListTile(
                                leading: Icon(
                                  Icons.shower,
                                  color: Colors.blueAccent,
                                ),
                                title: Text(
                                  'Session on ${session.date}',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                subtitle: Text(
                                  'Phases: ${session.phases.length}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        foregroundColor: Color.fromARGB(255, 64, 147, 242),
                        elevation: 5,
                        shadowColor: Colors.black45,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewSessionScreen()),
                        );
                      },
                      child: Text(
                        'Start New Session',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}