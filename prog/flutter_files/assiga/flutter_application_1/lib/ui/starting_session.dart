import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import "showering_page.dart";

const double _kItemExtent = 32.0;
const List<String> _difficulties = <String>[
  'Test',
  'Easy',
  'Medium',
  'Hard',
];

int interpretHot(String difficulty) {
  if (difficulty == 'Easy') {
    return 90;
  } else if (difficulty == 'Medium') {
    return 60;
  } else if (difficulty == 'Hard') {
    return 30;
  } else if (difficulty == 'Test') {
    return 2;
  } else {
    return 0;
  }
}

int interpretCold(String difficulty) {
  if (difficulty == 'Easy') {
    return 30;
  } else if (difficulty == 'Medium') {
    return 45;
  } else if (difficulty == 'Hard') {
    return 60;
  } else if (difficulty == 'Test') {
    return 2;
  } else {
    return 0;
  }
}

class StartingSession extends StatefulWidget {
  const StartingSession({super.key});

  @override
  State<StartingSession> createState() => _StartingSessionState();
}

class _StartingSessionState extends State<StartingSession> {
  int _selectedDifficulty = 0;

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Select the level'),
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Select the level ",
                // style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
              ),
              const SizedBox(height: 100),
              const Column(
                children: [
                  CupertinoListTile(
                    leading: Icon(
                      Icons.settings,
                    ),
                    title: Text('Test'),
                    subtitle:
                        Text('2 seconds of hot water, 2 seconds of cold water'),
                  ),
                  SizedBox(height: 30),
                  CupertinoListTile(
                    leading: Icon(
                      Icons.sentiment_neutral_outlined,
                    ),
                    title: Text('Easy'),
                    subtitle: Text(
                        '90 seconds of hot water, 30 seconds of cold water'),
                  ),
                  SizedBox(height: 30),
                  CupertinoListTile(
                    leading: Icon(
                      Icons.sentiment_dissatisfied_outlined,
                    ),
                    title: Text('Medium'),
                    subtitle: Text(
                        '60 seconds of hot water, 45 seconds of cold water'),
                  ),
                  SizedBox(height: 30),
                  CupertinoListTile(
                    leading: Icon(
                      Icons.sentiment_very_dissatisfied_outlined,
                    ),
                    title: Text('Hard'),
                    subtitle: Text(
                        '30 seconds of hot water, 60 seconds of cold water'),
                  ),
                  SizedBox(height: 60),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Selected difficulty: ',
                    // style: CupertinoTheme.of(context).textTheme.pickerTextStyle,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    // Display a CupertinoPicker with list of fruits.
                    onPressed: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: _kItemExtent,
                        // This sets the initial item.
                        scrollController: FixedExtentScrollController(
                          initialItem: _selectedDifficulty,
                        ),
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedDifficulty = selectedItem;
                          });
                        },
                        children: List<Widget>.generate(_difficulties.length,
                            (int index) {
                          return Center(child: Text(_difficulties[index]));
                        }),
                      ),
                    ),
                    // This displays the selected fruit name.
                    child: Text(
                      _difficulties[_selectedDifficulty],
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: const Text('Go!'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ShoweringPage(
                        hotSeconds:
                            interpretHot(_difficulties[_selectedDifficulty]),
                        coldSeconds:
                            interpretCold(_difficulties[_selectedDifficulty]),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
