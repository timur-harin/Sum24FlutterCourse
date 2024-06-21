import 'package:education/templates/middleAssignment/data/provider/providers.dart';
import 'package:education/templates/middleAssignment/data/models/shower_session.dart';
import 'package:education/templates/middleAssignment/ui/theme/constants.dart';
import 'package:education/templates/middleAssignment/ui/widgets/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<ShowerSession> sessions = [];
  bool showLastFive = true;

  @override
  void initState() {
    super.initState();
    _loadSessionsData();
  }

  Future<void> _loadSessionsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? sessionsJson = prefs.getStringList('sessions');
    if (sessionsJson != null) {
      setState(() {
        sessions = sessionsJson
            .map((session) => ShowerSession.fromJson(session))
            .toList();
      });
    }
  }

  List<ShowerSession> get lastFiveSessions {
    if (sessions.length <= 5) {
      return sessions;
    }
    return sessions.sublist(sessions.length - 5);
  }

  @override
  Widget build(BuildContext context) {
    final sessions = ref.watch(sessionProvider);
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {
                setState(() {
                  showLastFive = !showLastFive;
                });
              },
              child: Text(
                  showLastFive ? 'Show all sessions' : 'Show recent sessions',
                  style: buttonTextStyle.copyWith(color: Colors.blue)),
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
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
                            child: Text("Total time",
                                style: smallHeadingTextStyle)),
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
                    if (this.sessions != [])
                      for (ShowerSession session in (showLastFive
                          ? lastFiveSessions.reversed
                          : this.sessions.reversed))
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/sessionDetails',
                                arguments: session);
                          },
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text(session.startTime)),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(flex: 2, child: Text(session.level)),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(flex: 2, child: Text(session.totalTime)),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(
                                  flex: 3,
                                  child: Text(session.numbOfCycles.toString())),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(flex: 2, child: Text(session.rate)),
                            ],
                          ),
                        ),
                    const Padding(
                        padding: EdgeInsets.only(top: 2 * paddingSize)),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(flex: 1),
        ],
      )),
    );
  }
}
