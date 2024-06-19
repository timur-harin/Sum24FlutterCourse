import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:device_screen_size/device_screen_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: DeviceScreenSize.screenHeightInPercentage(
                                  context) /
                              0.7,
                          width:
                              DeviceScreenSize.screenWidthInPercentage(context),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height:
                                    DeviceScreenSize.screenHeightInPercentage(
                                            context) *
                                        1.8 *
                                        0.015,
                              ),
                              const Text(
                                'Session Settings',
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    DeviceScreenSize.screenHeightInPercentage(
                                            context) *
                                        1.8 *
                                        0.015,
                              ),
                              const Divider(
                                height: 0,
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              SizedBox(
                                height:
                                    DeviceScreenSize.screenHeightInPercentage(
                                            context) *
                                        1.8 *
                                        0.015,
                              ),
                              const Text(
                                'Hot shower phase',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              MySlider(
                                divisions: 10,
                                max: 300,
                                isTime: true,
                              ),
                              SizedBox(
                                height:
                                    DeviceScreenSize.screenHeightInPercentage(
                                            context) *
                                        1.8 *
                                        0.005,
                              ),
                              const Text(
                                'Cold shower phase',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              MySlider(
                                divisions: 10,
                                max: 300,
                                isTime: true,
                              ),
                              SizedBox(
                                height:
                                    DeviceScreenSize.screenHeightInPercentage(
                                            context) *
                                        1.8 *
                                        0.005,
                              ),
                              const Text(
                                'Phases amount',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              MySlider(
                                divisions: 10,
                                max: 10,
                                isTime: false,
                              )
                            ],
                          ),
                        );
                      });
                },
                child: const Text('New Session')),
          ],
        ),
      ),
    );
  }
}

class MySlider extends StatefulWidget {
  MySlider(
      {super.key,
      required this.divisions,
      required this.max,
      required this.isTime});
  int divisions;
  double max;
  bool isTime;
  @override
  State<StatefulWidget> createState() => _MySliderState(
        divisions: divisions,
        max: max,
        isTime: isTime,
      );
}

class _MySliderState extends State<MySlider> {
  _MySliderState(
      {required this.divisions, required this.max, required this.isTime});
  int divisions;
  double max;
  bool isTime;
  double _currentValue = 0;

  String secondsToMinutesSeconds(int totalSeconds) {
    int minutes = (totalSeconds / 60).floor();
    int remainingSeconds = totalSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: DeviceScreenSize.screenWidthInPercentage(context) / 1.2,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Slider(
              label: _currentValue.round().toString(),
              value: _currentValue,
              divisions: divisions,
              max: max,
              onChanged: (double value) {
                setState(() {
                  _currentValue = value;
                });
              },
            ),
          ),
          Text(
            isTime
                ? "${secondsToMinutesSeconds(_currentValue.round())} m"
                : _currentValue.round().toString(),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
