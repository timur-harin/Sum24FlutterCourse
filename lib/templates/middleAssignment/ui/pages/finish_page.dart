import 'package:education/templates/middleAssignment/data/provider/providers.dart';
import 'package:education/templates/middleAssignment/ui/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishPage extends ConsumerStatefulWidget {
  const FinishPage({super.key});

  @override
  ConsumerState<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends ConsumerState<FinishPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        ref.read(sessionProvider);

  }
  
  @override
  Widget build(BuildContext context) {
        final sessions = ref.watch(sessionProvider);

    return  Scaffold(
       appBar: AppBar(
        title: const Text(
          "Active session",
          style: headingStyle,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Session Complete!'),
            const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
            Text(
              sessions.sessions.last.level
            ),
            Text(sessions.sessions.last.startTime.toString()),
            Text(sessions.sessions.last.endTime.toString()),
            Text(sessions.sessions.last.name),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD9D9D9),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("/home");
              },
              child: const Text(
                "Rate",
                style: buttonTextStyle,
              ),
            ),

          ],
        ),
      ),  
    );
  }
}