import 'package:education/templates/middleAssignment/notifier.dart';
import 'package:education/templates/middleAssignment/sessionSettings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homescreen extends ConsumerWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(SessionProvider);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 126, 212, 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Column(
            children: [
              AppBar(
                backgroundColor: const Color.fromRGBO(53, 126, 212, 1),
                centerTitle: true,
                title: const Text(
                  "Showing sessions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Title',
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: (sessions.duration.isNotEmpty &&
                          sessions.timeStart.isNotEmpty)
                      ? ListView.builder(
                          itemCount: sessions.duration.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(53, 175, 212, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      width: 5)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Row(children: [
                                const Icon(
                                  Icons.hourglass_bottom,
                                  size: 34,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "${sessions.duration[index]} min",
                                  style: TextStyle(fontSize: 22),
                                ),
                                const SizedBox(
                                  width: 22,
                                ),
                                const Icon(
                                  Icons.date_range,
                                  size: 34,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(sessions.timeStart[index]),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ]),
                            );
                          },
                        )
                      : const Text(""),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sessionsettings()),
          );
        },
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(15)),
          backgroundColor:
              WidgetStateProperty.all(const Color.fromRGBO(53, 175, 212, 1)),
        ),
        icon: const Icon(
          Icons.shower,
          size: 50,
        ),
      ),
    );
  }
}
