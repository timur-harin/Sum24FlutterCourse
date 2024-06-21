import 'package:education/templates/middleAssignment/data/functions.dart';
import 'package:education/templates/middleAssignment/data/provider/providers.dart';
import 'package:education/templates/middleAssignment/data/shower_session.dart';
import 'package:education/templates/middleAssignment/data/workout.dart';
import 'package:education/templates/middleAssignment/ui/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {


  final TextEditingController _controller = TextEditingController();

// final showerProvider = Provider.of<ShowerProvider>(
//   context
// );
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(sessionProvider);
  }
  @override
  Widget build(BuildContext context) {
      final sessions = ref.watch(sessionProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(padding: EdgeInsets.only(top: paddingSize)),
          Text(
            "Take a shower with me ;)",
            style: headingStyle,
          ),
          const Padding(padding: EdgeInsets.only(top: paddingSize)),
          Container(
            height: 40,
            width: 250,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9D9D9)),
                onPressed: () {
                  Navigator.of(context).pushNamed("/shower");
                },
                child: const Text(
                  "Start new session",
                  style: buttonTextStyle,
                )),
          ),
          const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
          Column(
            children: [
              if (sessions.sessions!=[])
              for (ShowerSession session in sessions.sessions)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(session.name),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Text(session.level),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Text(session.startTime.toString()),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Text(session.endTime.toString()),
                  ],
                ),
                Container(),
            ],
          ),
         
        ],
      )),
    );
  }
}
