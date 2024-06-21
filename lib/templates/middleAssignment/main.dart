import 'package:hive/hive.dart';
import 'hive_service.dart';
import 'package:flutter/material.dart';
import 'package:device_screen_size/device_screen_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session.dart';
import 'providers.dart';
import 'data.dart';
import 'package:hive_flutter/hive_flutter.dart';

String secondsToMinutesSeconds(int totalSeconds) {
  int minutes = (totalSeconds / 60).floor();
  int remainingSeconds = totalSeconds % 60;

  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}

var dataBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DataAdapter());
  dataBox = await Hive.openBox<Data>('data');
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
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

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Data> data = HiveService.getAll();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Table(
                  border:
                      TableBorder.all(color: Color.fromARGB(255, 28, 130, 213)),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FixedColumnWidth(100),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.7),
                      ),
                      children: [
                        TableCell(
                          child: Container(
                            child: Text(
                              'Hot Shower Time',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(
                              'Cold Shower Time',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(
                              'Total Time',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(
                              'Total Phases',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(
                              'Rating',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...data.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final Data item = entry.value;
                      return TableRow(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.4),
                        ),
                        children: [
                          TableCell(
                            child: Container(
                              child: Text(
                                  secondsToMinutesSeconds(item.hotShowerTime),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 76, 128))),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text(
                                  secondsToMinutesSeconds(item.coldShowerTime),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 76, 128))),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text(
                                  secondsToMinutesSeconds(item.totalTime),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 76, 128))),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text(item.totalPhases.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 76, 128))),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text(item.rating.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 76, 128))),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
                foregroundColor: Colors.blue.withOpacity(0.8),
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                side: BorderSide(color: Colors.blue.withOpacity(0.8)),
              ),
              onPressed: () {
                ref.read(hotShowerPhaseProvider.notifier).state = 30;
                ref.read(coldShowerPhaseProvider.notifier).state = 30;
                ref.read(phasesAmountProvider.notifier).state = 2;
                ref.read(startHotShowerProvider.notifier).state = true;
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      height:
                          DeviceScreenSize.screenHeightInPercentage(context) /
                              0.7,
                      width: DeviceScreenSize.screenWidthInPercentage(context),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: DeviceScreenSize.screenHeightInPercentage(
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
                            height: DeviceScreenSize.screenHeightInPercentage(
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
                            height: DeviceScreenSize.screenHeightInPercentage(
                                    context) *
                                1.8 *
                                0.02,
                          ),
                          const Text(
                            'Hot shower phase',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          MySlider(
                              divisions: 9,
                              max: 300,
                              isTime: true,
                              provider: hotShowerPhaseProvider,
                              min: 30),
                          SizedBox(
                            height: DeviceScreenSize.screenHeightInPercentage(
                                    context) *
                                1.8 *
                                0.005,
                          ),
                          const Text(
                            'Cold shower phase',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          MySlider(
                              divisions: 9,
                              max: 300,
                              isTime: true,
                              provider: coldShowerPhaseProvider,
                              min: 30),
                          SizedBox(
                            height: DeviceScreenSize.screenHeightInPercentage(
                                    context) *
                                1.8 *
                                0.005,
                          ),
                          const Text(
                            'Phases amount',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          MySlider(
                              divisions: 8,
                              max: 10,
                              isTime: false,
                              provider: phasesAmountProvider,
                              min: 2),
                          SizedBox(
                            height: DeviceScreenSize.screenHeightInPercentage(
                                    context) *
                                1.8 *
                                0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 150,
                                height: 50,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30),
                                    foregroundColor:
                                        Colors.blue.withOpacity(0.8),
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    side: BorderSide(
                                        color: Colors.blue.withOpacity(0.8)),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Session Settings'),
                                            content: Text(
                                              'Hot shower time: ${secondsToMinutesSeconds(ref.read(hotShowerPhaseProvider).toInt())} minutes\n'
                                              'Cold shower time: ${secondsToMinutesSeconds(ref.read(coldShowerPhaseProvider).toInt())} minutes\n'
                                              'Phases amount: ${ref.read(phasesAmountProvider)}\n'
                                              'Start with ${ref.read(startHotShowerProvider) ? 'hot' : 'cold'} shower\n'
                                              'Total time: ${secondsToMinutesSeconds(((ref.read(phasesAmountProvider) / 2).ceil() * (ref.read(startHotShowerProvider) ? ref.read(hotShowerPhaseProvider) : ref.read(coldShowerPhaseProvider)) + (ref.read(phasesAmountProvider) / 2).floor() * (ref.read(startHotShowerProvider) ? ref.read(coldShowerPhaseProvider) : ref.read(hotShowerPhaseProvider))).round())}',
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Session(),
                                                    ),
                                                  )
                                                },
                                                child: Text(
                                                  'Begin Session',
                                                  style: TextStyle(
                                                      color: Colors.blue
                                                          .withOpacity(0.8)),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.blue.withOpacity(0.8)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 60),
                              const MySwitch()
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text('Start New Session'),
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey,
                  side: const BorderSide(color: Colors.transparent),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.all(16.0),
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
                              const Text('How to use this app?',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
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
                                        0.02,
                              ),
                              const Text(
                                'The main page contains the history of the sessions held. '
                                'In order to start the next one, just click on "Start New Session", select the time for each phase, as well '
                                'as the number of phases and the first phase (by swiping on the switch), and click on "Next". '
                                'During a session, you can end it early by clicking on "Finish" or pause it by clicking on "Pause". '
                                'After the end of the session you will be provided with statistics and the opportunity to evaluate it',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: const Text(
                  'Hint',
                ))
          ],
        ),
      ),
    );
  }
}

class MySlider extends ConsumerStatefulWidget {
  MySlider({
    super.key,
    required this.divisions,
    required this.max,
    required this.isTime,
    required this.provider,
    required this.min,
  });

  final int divisions;
  final double max;
  final bool isTime;
  final StateProvider<double> provider;
  final double min;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MySliderState();
}

class _MySliderState extends ConsumerState<MySlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.min;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: DeviceScreenSize.screenWidthInPercentage(context) / 1.2,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.blue,
                thumbColor: Colors.blue,
                valueIndicatorColor: Colors.blue),
            child: Slider(
              min: widget.min,
              label: _currentValue.round().toString(),
              value: _currentValue,
              divisions: widget.divisions,
              max: widget.max,
              onChanged: (double value) {
                setState(() {
                  _currentValue = value;
                  ref.read(widget.provider.notifier).state = value;
                });
              },
            ),
          )),
          Text(
            widget.isTime
                ? "${secondsToMinutesSeconds(_currentValue.round())} m"
                : _currentValue.round().toString(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class MySwitch extends ConsumerStatefulWidget {
  const MySwitch({super.key});

  @override
  ConsumerState<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends ConsumerState<MySwitch> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      activeColor: Colors.orange,
      activeTrackColor: const Color.fromARGB(255, 255, 202, 123),
      inactiveThumbColor: Color(0xFF2196F3),
      inactiveTrackColor: const Color.fromARGB(255, 135, 189, 234),
      onChanged: (bool value) {
        setState(() {
          light = value;
          ref.read(startHotShowerProvider.notifier).state = value;
          ref.read(backgroundColorProvider.notifier).state =
              !value ? Colors.lightBlue : Colors.orange;
        });
      },
    );
  }
}
