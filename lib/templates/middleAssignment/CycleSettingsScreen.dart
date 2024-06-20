import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PickerValues.dart';
import 'homeScreen.dart';
import 'ShowerCycle.dart';
import 'storage.dart';
import 'ShowerProcessScreen.dart';

class CycleSettingsScreen extends StatefulWidget{
  const CycleSettingsScreen({super.key});

  @override
  State<CycleSettingsScreen> createState() => _CycleSettingsScreen();
}

class _CycleSettingsScreen extends State<CycleSettingsScreen> {
  int _coldCycleLength = 1;
  int _hotCycleLength = 1;
  int _numberOfCycles = 1;
  bool _extraShowerPhase = false;
  String _beginningPhase = "Hot water";
  Color _beginningPhaseColor = Colors.red;

  final LocalStorage _localStorage = LocalStorage();

  void _saveShowerCycle() async {
    ShowerCycle showerCycle = ShowerCycle(
        hotWaterMinutes: _hotCycleLength,
        coldWaterMinutes: _coldCycleLength,
        numberOfCycles: _numberOfCycles,
        startingPhase: _beginningPhase,
        includeAdditionalTemperatureChange: _extraShowerPhase
    );

    await _localStorage.saveShower(showerCycle);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Shower cycle saved successfully!')),
    );

    // Navigate back to the home screen and update the history
    Navigator.pop(context, true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Home()
                  )
              );
            },
            icon: const Icon(
                Icons.arrow_back_outlined
            )
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CupertinoButton(
              color: Colors.blue,
              onPressed: () => showCupertinoModalPopup(
                context: context,
                builder: (_) => SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    scrollController: FixedExtentScrollController(
                        initialItem: 0
                    ),
                    children: PickerValues().values(),
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        _coldCycleLength = value + 1;
                      });
                    },
                  ),
                ),
              ),
              child: Text("Cold water time: $_coldCycleLength minutes"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: CupertinoButton(
              color: Colors.red,
                child: Text("Hot water time: $_hotCycleLength minutes"),
                onPressed: () => showCupertinoModalPopup(
                  context: context,
                  builder: (_) => SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 30,
                      scrollController: FixedExtentScrollController(
                        initialItem: 0
                      ),
                      children: PickerValues().values(),
                      onSelectedItemChanged: (int value) {
                        setState(() {
                          _hotCycleLength = value + 1;
                        });
                      },
                    ),
                  )
                )
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: CupertinoButton(
                color: Colors.greenAccent,
                child: Text("Number of cycles: $_numberOfCycles"),
                onPressed: () => showCupertinoModalPopup(
                    context: context,
                    builder: (_) => SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: CupertinoPicker(
                        backgroundColor: Colors.white,
                        itemExtent: 30,
                        scrollController: FixedExtentScrollController(
                            initialItem: 0
                        ),
                        children: PickerValues().values(),
                        onSelectedItemChanged: (int value) {
                          setState(() {
                            _numberOfCycles = value + 1;
                          });
                        },
                      ),
                    )
                )
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Extra shower phase: ",
                ),
                Checkbox(
                    value: _extraShowerPhase,
                    activeColor: Colors.blue,
                    hoverColor: Colors.cyan,
                    onChanged: (bool? value) {
                      setState(() {
                        _extraShowerPhase = value!;
                      });
                    }
                )
              ],
            ),
          ),
          Center(
            child: CupertinoButton(
              color: _beginningPhaseColor,
              child: Text("Beginning phase: $_beginningPhase"),
              onPressed: () => showCupertinoModalPopup(
                context: context,
                builder: (_) => SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    scrollController: FixedExtentScrollController(
                        initialItem: _beginningPhase == "Hot water" ? 0 : 1
                    ),
                    children: const [
                      Text("Hot water"),
                      Text("Cold water"),
                    ],
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        _beginningPhase = value == 0 ? "Hot water" : "Cold water";
                        _beginningPhaseColor = value == 0 ? Colors.red : Colors.blue;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowerProcessScreen(
                        showerCycle: ShowerCycle(
                            hotWaterMinutes: _hotCycleLength,
                            coldWaterMinutes: _coldCycleLength,
                            numberOfCycles: _numberOfCycles,
                            startingPhase: _beginningPhase,
                            includeAdditionalTemperatureChange: _extraShowerPhase))));
                if (result) {
                  Navigator.pop(context, true);
                }
              },
              child: const Icon(
                Icons.play_arrow,
                color: Colors.blue,
              )
          )
        ]
      )
    );
  }
  
}