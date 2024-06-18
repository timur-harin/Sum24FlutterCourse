import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PickerValues.dart';
import 'homeScreen.dart';

class CycleSettingsScreen extends StatefulWidget{
  const CycleSettingsScreen({super.key});

  @override
  State<CycleSettingsScreen> createState() => _CycleSettingsScreen();
}

class _CycleSettingsScreen extends State<CycleSettingsScreen> {
  int _coldCycleLength = 0;
  int _hotCycleLength = 0;
  int _numberOfCycles = 0;
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
          ElevatedButton(
              onPressed: () {},
              child: IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.blue,
                ),
                onPressed: () {},
              )
          )
        ]
      )
    );
  }
  
}