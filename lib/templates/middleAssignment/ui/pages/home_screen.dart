import 'package:education/templates/middleAssignment/data/functions.dart';
import 'package:education/templates/middleAssignment/data/models/shared_preferences.dart';
import 'package:education/templates/middleAssignment/data/provider/providers.dart';
import 'package:education/templates/middleAssignment/data/models/shower_session.dart';
import 'package:education/templates/middleAssignment/ui/theme/constants.dart';
import 'package:education/templates/middleAssignment/ui/widgets/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // _loadSessionsData();
  }

  // void _loadSessionsData() {
  //   ref
  //       .read(sessionProvider)
  //       .loadSessions(); // Assuming loadSessions is defined in the notifier
  // }

  @override
  Widget build(BuildContext context) {
    final sessions = ref.watch(sessionProvider);
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: smallPaddingSize)),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(smallPaddingSize),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Take a shower with me ;)",
                  style: headingStyle,
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: paddingSize)),
          const Expanded(
              flex: 3,
              child: Icon(
                CustomIcons.shower,
                size: 80,
                color: Color(0xFF4A6B7E),
              )),
          Expanded(
            flex: 1,
            child: Container(
              height: 45,
              width: 250,
              child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/shower");
                  },
                  child: const Text(
                    "Start new session",
                    style: buttonTextStyle,
                  )),
            ),
          ),
          const Spacer(flex: 1),
          const Padding(padding: EdgeInsets.only(top: paddingSize)),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(paddingSize),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text("Date of start",
                              style: smallHeadingTextStyle)),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                          flex: 2,
                          child: Text("Level", style: smallHeadingTextStyle)),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                          flex: 2,
                          child:
                              Text("Total time", style: smallHeadingTextStyle)),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                          flex: 3,
                          child: Text("№ of cycles",
                              style: smallHeadingTextStyle)),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                          flex: 2,
                          child: Text("Rate", style: smallHeadingTextStyle)),
                    ],
                  ),
                  if (sessions.sessions != [])
                    for (ShowerSession session in sessions.sessions)
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(sessions.sessions.last.startTime)),
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          Expanded(flex: 2, child: Text(session.level)),
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          Expanded(flex: 2, child: Text(session.totalTime)),
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          Expanded(
                              flex: 3,
                              child: Text(session.numbOfCycles.toString())),
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          Expanded(flex: 2, child: Text(session.rate!)),
                        ],
                      ),
                  const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
