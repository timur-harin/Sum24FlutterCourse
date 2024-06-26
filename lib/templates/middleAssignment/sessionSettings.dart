import 'package:education/templates/middleAssignment/notifier.dart';
import 'package:education/templates/middleAssignment/sessionCreation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Sessionsettings extends ConsumerWidget {
  const Sessionsettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _controller1 = TextEditingController();
    TextEditingController _controller2 = TextEditingController();
    final sessions = ref.watch(SessionProvider);

    return Scaffold(
        backgroundColor: const Color.fromRGBO(53, 126, 212, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(53, 126, 212, 1),
          centerTitle: true,
          title: const SizedBox(
            height: 50,
            child: Text(
              "Showing sessions",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Title'),
            ),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Input the duration of your shower:",
              style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 20),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  fillColor: Color.fromRGBO(53, 175, 212, 1),
                  filled: true,
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontSize: 18,
                  ),
                  labelText: 'Shower duration in minutes',
                  counterStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1), width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
            ),
            TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  fillColor: Color.fromRGBO(53, 175, 212, 1),
                  filled: true,
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontSize: 18,
                  ),
                  labelText: 'Shower phase duration in seconds',
                  counterStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1), width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
            ),
            const SizedBox(
              height: 25,
            ),
            TextButton(
              onPressed: () {
                if (!_controller1.text.toString().isEmpty &&
                    !_controller2.text.toString().isEmpty) {
                  sessions.startSession(_controller1.text.toString(),
                      _controller2.text.toString());

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (const SessionCreation())));
                }
              },
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromRGBO(53, 175, 212, 1)),
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 45))),
              child: const Text(
                "Start",
                style:
                    TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 24),
              ),
            )
          ],
        )));
  }
}
