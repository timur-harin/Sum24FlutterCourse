import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shower_companion/models/shower_session.dart';
import 'package:shower_companion/providers/shower_session_provider.dart';
import 'current_session_screen.dart';

class CreateSessionScreen extends ConsumerStatefulWidget {
  const CreateSessionScreen({super.key});

  @override
  _CreateSessionScreenState createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends ConsumerState<CreateSessionScreen> {
  List<ShowerSessionStep> steps = [];
  Duration totalDuration = Duration.zero;
  int minutes = 0;
  int totalTime = 0;
  final TextEditingController _controller = TextEditingController();
  bool isHot = false;

  void addStep(bool isHot, Duration duration) {
    setState(() {
      steps.add(ShowerSessionStep(isHot: isHot, duration: duration));
      totalDuration += duration;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('MMMM d, EEEE').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Starting a new session',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 70,
              child: Center(
                child: Text(
                  'Total time: $totalTime min',
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
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
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: TextField(
                                    controller: _controller,
                                    decoration: const InputDecoration(
                                      hintText: "Enter time (min) :",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        minutes = int.tryParse(value) ?? 0;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isHot = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Text(
                                      '🔥',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isHot = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Text(
                                      '🧊',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              if (minutes != 0) {
                                addStep(isHot, Duration(minutes: minutes));
                                setState(() {
                                  totalTime += minutes;
                                });
                              }
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              textStyle: const TextStyle(fontSize: 30),
                            ),
                            child: const Text("✅"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 400,
              child: ListView.builder(
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final step = steps[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 60,
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
                                    "${step.duration.inMinutes} min",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    step.isHot ? '🔥' : '🧊',
                                    style: const TextStyle(fontSize: 30),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            CreateSessionWidget(
              totalDuration: totalDuration,
              steps: steps,
              ref: ref,
              date: currentDate,
            ),
          ],
        ),
      ),
    );
  }
}

class CreateSessionWidget extends StatelessWidget {
  final Duration totalDuration;
  final List<ShowerSessionStep> steps;
  final WidgetRef ref;
  final String date;

  const CreateSessionWidget({
    super.key,
    required this.totalDuration,
    required this.steps,
    required this.ref,
    required this.date,
  });

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
                      padding: EdgeInsets.only(left: 27.0),
                      child: Text('Confirm a new session',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.0),
                      child: Text(
                          'press the button and start your contrast shower',
                          style: TextStyle(
                              color: Color.fromRGBO(100, 100, 100, 1),
                              fontSize: 15)),
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
                    if (totalDuration.inSeconds != Duration.zero.inSeconds) {
                    final session = ShowerSession(
                      totalDuration: totalDuration,
                      steps: steps,
                      date: date,
                    );
                    ref
                        .read(showerSessionProvider.notifier)
                        .addSession(session);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CurrentSessionScreen(session: session)),
                    );
                    }
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
