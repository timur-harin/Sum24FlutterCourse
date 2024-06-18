import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/storage.dart';
import 'package:education/templates/middleAssignment/addSessionScreen.dart';
import 'package:intl/intl.dart';
import 'package:education/templates/middleAssignment/customExpansion.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Map<String, List<ShowerSession>> _groupSessionsByDate(List<ShowerSession> sessions) {
  final Map<String, List<ShowerSession>> grouped = {};

    for (var session in sessions) {
      final formattedDate = DateFormat('d MMMM, yyyy', 'en_US').format(session.date);
      if (grouped.containsKey(formattedDate)) {
        grouped[formattedDate]!.add(session);
      } else {
        grouped[formattedDate] = [session];
      }
    }
    return grouped;
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localStorageService = LocalStorageService();

  return Scaffold(
    appBar: AppBar(
      title: const Text('Contrast Showers',),
      backgroundColor: const Color(0xFF24305E),
      foregroundColor: Colors.white,
    ),
    body: FutureBuilder<List<ShowerSession>>(
        future: localStorageService.getSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading sessions'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No sessions available'));
          }

          final sessions = snapshot.data!;
          final groupedSessions = _groupSessionsByDate(sessions);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Shower Sessions',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: ListView(
                  children: groupedSessions.entries.map((entry) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 213, 235, 255),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: CustomExpansionTile(
                        title: entry.key,
                        children: entry.value.asMap().entries.map((sessionEntry) {
                          final sessionIndex = sessionEntry.key + 1;
                          final session = sessionEntry.value;

                          List<Widget> sessionChildren = session.phases.map((phase) {
                            return ListTile(
                              title: Text(
                                phase.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                      color: phase.name == 'hot' 
                                      ? const Color.fromARGB(255, 155, 36, 36) 
                                      : const Color(0xFF374785),
                                ),
                              ),
                              subtitle: Text(
                                '${phase.duration.inMinutes} minutes',
                                textAlign: TextAlign.left,
                                style: const TextStyle(color: const Color(0xFF24305E)),
                              ),
                            );
                          }).toList();

                          if (session.feedback != null && session.feedback!.isNotEmpty) {
                            sessionChildren.add(
                              ListTile(
                                title: Text(
                                  "Feedback",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: const Color(0xFF24305E)),
                                ),
                                subtitle: Text(
                                  session.feedback!,
                                  style: const TextStyle(color: const Color(0xFF24305E)),
                                ),
                              ),
                            );
                          }
                          return CustomExpansionTile(
                            title: 'Session $sessionIndex',
                            children: sessionChildren,
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSessionScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF24305E),
          foregroundColor: Colors.white,
        ),
        child: const Text('Start New Session'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}