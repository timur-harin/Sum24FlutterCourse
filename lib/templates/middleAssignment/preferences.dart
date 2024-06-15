import 'package:flutter/material.dart';
import 'timer_screen.dart';

class Preferences extends StatefulWidget {
  @override
  PreferencesState createState() => PreferencesState(10, 5, 10);
}

class PreferencesState extends State<Preferences> {

  PreferencesState(this.duration, this.minTemp, this.maxTemp);

  int duration;
  int minTemp;
  int maxTemp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(209, 68, 137, 255),
            Color.fromARGB(106, 155, 39, 176),
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
            title: Text('Temperature intervals: from $minTemp°C to $maxTemp°C'),
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
            const Text('              Choose minimal temperature:  '),
            ElevatedButton(
              onPressed: () => {
                if (minTemp + 1 <= maxTemp) {
                  setState(() {minTemp++;})
                  } else {
                    setState(() {minTemp = maxTemp;})
                  }
              },
              child: const Text('+'),
              onLongPress: () => {if (minTemp + 5 <= maxTemp) {
                setState(() {minTemp += 5;})
                } else {
                  setState(() {minTemp = maxTemp;})
                }
                },
            ),
            ElevatedButton(
              onPressed: () => {setState(() {minTemp--;})},
              child: const Text('-'),
              onLongPress: () => {setState(() {
              minTemp -= 5;
              }
              )
              },
            ),
          ],
      ),
      Row(children: [
        const Text('              Choose maximal temperature:  '),
        ElevatedButton(
          onPressed: () => {setState(() {maxTemp++;})},
          child: const Text('+'),
          onLongPress: () => {setState(() {maxTemp += 5;})},
        ),
        ElevatedButton(
          onPressed: () => {
            if(maxTemp - 1 >= minTemp) { 
              setState(() {maxTemp--;})
              } else {
                setState(() {maxTemp = minTemp;})
              }
              },
          child: const Text('-'),
          onLongPress: () => {
            if(maxTemp - 5 >= minTemp) { 
              setState(() { maxTemp -= 5;})
            } else {
              setState(() { maxTemp = minTemp;})
            } 
            },
        ),
      ],
      ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimerPage(preferencesState: PreferencesState(duration, minTemp, maxTemp))),
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