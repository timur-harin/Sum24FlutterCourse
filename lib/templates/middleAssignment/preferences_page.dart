import 'package:flutter/material.dart';
import 'timer_page.dart';

class Preferences extends StatefulWidget {
  @override
  PreferencesState createState() => PreferencesState(10, 5);
}

class PreferencesState extends State<Preferences> {

  PreferencesState(this.duration, this.switches, {this.waterType = "Hot"});

  int duration;
  int switches;
  String waterType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(209, 68, 137, 255),
            Color.fromARGB(213, 255, 82, 82),
          ],
        ),
      ),
    child: Scaffold(
      backgroundColor: const Color.fromARGB(0, 244, 67, 54),
      appBar: AppBar(
        title: const Text('Customise your preferences'),
        backgroundColor: const Color.fromARGB(255, 62, 160, 185)
      ),
      body: ListView(
  children: [
    Center(
      child: Column(
        children: [
          const Text('Preferences:  ', style: TextStyle(fontSize: 20)),
          ListTile(
            title: Text('Duration: $duration minutes'),
            leading: const Icon(Icons.timer),
          ),
          ListTile(
            title: Text('Number of cycles: $switches'),
            leading: const Icon(Icons.rotate_left),
          ),
          ListTile(
            title: Text('Start with: $waterType water'), 
            leading: const Icon(Icons.thermostat), 
          ),
          const Text('Settings:  ', style: TextStyle(fontSize: 20)),
          Row(
            children: [
              const Text('              Choose duration:  '),
              ElevatedButton(
                onPressed: () => {setState(() {duration++;})}, 
                child: const Text('+'),
                onLongPress: () => {setState(() {duration += 5;})},
              ),
              ElevatedButton(
                onPressed: () => {setState(() {if (duration > 0) duration--;})},
                child: const Text('-'),
                onLongPress: () => {setState(() {
                  if (duration > 4) {duration -= 5;}
                  else {duration = 0;}
                })},
              ),
            ],
          ),
          Row(children: [
            const Text('              Choose number of switchs: '),
            ElevatedButton(
              onPressed: () => {
                if (switches < 20) {setState(() {switches++;})} 
              },
              child: const Text('+'),
            ),
            ElevatedButton(
              onPressed: () => {
                if (switches > 1) setState(() {switches--;})},
              child: const Text('-'),
            ),
          ],
        ),
        Row(children: [
            const Text('              What kind of water to start with? '),
            ElevatedButton(
              onPressed: () => {
                 setState(() {
                   waterType = "Hot";
                 }),
              },
              child: const Text('Hot'),
            ),
            ElevatedButton(
              onPressed: () => {
                setState(() {
                   waterType = "Cold";
                 }),
              },
              child: const Text('Cold'),
            ),
          ],
        ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimerPage(preferencesState: PreferencesState(duration, switches, waterType: waterType))),
              );
            },
            child: const Text('Start'),
          ),
        ],
      ),
    ),
  ],
)
),
    );
  }
}