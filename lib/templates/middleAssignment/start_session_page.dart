import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

class StartSessionPage extends StatefulWidget {
  const StartSessionPage({super.key});

  @override
  State<StartSessionPage> createState() => _StartSessionPage();
}

abstract class TemperaturePhase {
  String get description;
}

class ColdTemperaturePhase implements TemperaturePhase {
  @override
  String get description => 'Cold temperature';
}

class HotTemperaturePhase implements TemperaturePhase {
  @override
  String get description => 'Hot temperature';
}

class _StartSessionPage extends State<StartSessionPage> {
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: Scaffold(
        backgroundColor: Colors.lightGreen[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(100.0),
                child: Column(children: [
                  Text('Let\'s start a new session!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 2.0,
                            color: Colors.grey,
                          ),
                        ],
                      )),
                  Text('Choose a temperature regime and session duration below',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ]),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      DropdownMenu<TemperaturePhase>(
                        menuHeight: 200,
                        width: 300,
                        controller: temperatureController,
                        requestFocusOnTap: true,
                        label: const Text('Regime'),
                        onSelected: (TemperaturePhase? value) {
                          setState(() {
                            final data = Provider.of<DataProvider>(context,
                                listen: false);
                            data.updateTemperaturePhase(value);
                          });
                        },
                        dropdownMenuEntries: <TemperaturePhase>[
                          ColdTemperaturePhase(),
                          HotTemperaturePhase()
                        ].map<DropdownMenuEntry<TemperaturePhase>>(
                            (TemperaturePhase value) {
                          return DropdownMenuEntry<TemperaturePhase>(
                            value: value,
                            label: value.description,
                            style: MenuItemButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        height: 200,
                        child: TextField(
                          controller: durationController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (int.tryParse(value) != null) {
                              setState(() {
                                final data = Provider.of<DataProvider>(context,
                                    listen: false);
                                data.updateSessionDuration(
                                    Duration(seconds: int.parse(value)));
                              });
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter session duration (in seconds)',
                              hintText: 'e.g., 30'),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            backgroundColor:
                                const Color.fromARGB(255, 146, 146, 146),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/timerPage');
                          },
                          child: const Text('START',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
