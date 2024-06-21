import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:education/templates/middleAssignment/pages/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/outlinedButton.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  double hot_duration = 3;
  double cold_duration = 3;
  double times = 1;
  static const String sessionKey = "session";

  Future<void> setSession(String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(sessionKey, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 36, 36, 36),
      ),
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hot water duration: " + hot_duration.round().toString(),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFc0000b)),
            ),
            Slider(
              activeColor: Color(0xFFc0000b),
              value: hot_duration,
              min: 3,
              max: 90,
              divisions: 90 - 3,
              label: hot_duration.round().toString(),
              onChanged: (value) {
                setState(() {
                  hot_duration = value;
                });
              },
            ),
            Text(
              "Cold water duration: " + cold_duration.round().toString(),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1241cd)),
            ),
            Slider(
              activeColor: Color(0xff1241cd),
              value: cold_duration,
              min: 3,
              max: 90,
              divisions: 90 - 3,
              label: cold_duration.round().toString(),
              onChanged: (value) {
                setState(() {
                  cold_duration = value;
                });
              },
            ),
            Text(
              'Number of repetitions: ' + times.round().toString(),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff658DA7)),
            ),
            Slider(
              activeColor: Color(0xff658DA7),
              value: times,
              min: 1,
              max: 5,
              divisions: 5 - 1,
              label: times.round().toString(),
              onChanged: (value) {
                setState(() {
                  times = value;
                });
              },
            )
          ],
        ),
        GradientOutlinedButton(
          onPressed: () {
            ref.read(riverpod_hot.notifier).state = hot_duration;
            ref.read(riverpod_cold.notifier).state = cold_duration;
            ref.read(riverpod_times.notifier).state = 2 * times.round();
            setSession(times.round().toString());
            Navigator.pushNamed(context, '/timer');
          },
          child: GradientText(
            text: 'New Session',
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFFc0000b),
                Color(0xffc8002c),
                Color(0xffca0049),
                Color(0xffc30067),
                Color(0xffb40085),
                Color(0xff9a00a1),
                Color(0xff712aba),
                Color(0xff1241cd),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFc0000b),
              Color(0xffc8002c),
              Color(0xffca0049),
              Color(0xffc30067),
              Color(0xffb40085),
              Color(0xff9a00a1),
              Color(0xff712aba),
              Color(0xff1241cd),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ])),
    ));
  }
}
