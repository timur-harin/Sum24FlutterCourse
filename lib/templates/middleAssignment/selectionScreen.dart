import 'package:flutter/material.dart';
import 'overviewScreen.dart';

class SelectionScreen extends StatefulWidget {
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  double warmWaterSeconds = 1;
  double coldWaterSeconds = 1;
  double repeatCycles = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderWidget(
              label: 'Warm water (minutes)',
              min: 1,
              max: 240,
              divisions: 239,
              displayFormat: DisplayFormat.minutesAndSeconds,
              onChanged: (value) {
                setState(() {
                  warmWaterSeconds = value;
                });
              },
            ),
            SliderWidget(
              label: 'Cold water (seconds)',
              min: 1,
              max: 60,
              divisions: 59,
              displayFormat: DisplayFormat.seconds,
              onChanged: (value) {
                setState(() {
                  coldWaterSeconds = value;
                });
              },
            ),
            SliderWidget(
              label: 'Repeat cycles',
              min: 1,
              max: 5,
              divisions: 4,
              displayFormat: DisplayFormat.times,
              onChanged: (value) {
                setState(() {
                  repeatCycles = value;
                });
              },
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OverviewScreen(
                      warmWaterSeconds: warmWaterSeconds,
                      coldWaterSeconds: coldWaterSeconds,
                      repeatCycles: repeatCycles,
                    ),
                  ),
                );
              },
              child: Text('Begin Session'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green, // Text color
                side: BorderSide(color: Colors.green), // Border color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DisplayFormat { minutesAndSeconds, seconds, times }

class SliderWidget extends StatefulWidget {
  final String label;
  final double min;
  final double max;
  final int divisions;
  final DisplayFormat displayFormat;
  final ValueChanged<double> onChanged;

  SliderWidget({
    required this.label,
    required this.min,
    required this.max,
    required this.divisions,
    required this.displayFormat,
    required this.onChanged,
  });

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _currentValue = 0.0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.min;
  }

  String _formatValue(double value) {
    switch (widget.displayFormat) {
      case DisplayFormat.minutesAndSeconds:
        int seconds = value.toInt();
        int minutes = (seconds / 60).floor();
        int showedSeconds = seconds - (minutes * 60);
        return '$minutes min $showedSeconds sec';
      case DisplayFormat.seconds:
        return '${value.round()} sec';
      case DisplayFormat.times:
        return '${value.round()} time(s)';
      default:
        return value.toStringAsFixed(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Text(widget.label),
          Slider(
            value: _currentValue,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            label: _currentValue.toStringAsFixed(1),
            onChanged: (double value) {
              setState(() {
                _currentValue = value;
                widget.onChanged(value);
              });
            },
            activeColor: Colors.green,
            inactiveColor: Colors.green[100],
            thumbColor: Colors.green,
          ),
          Text(_formatValue(_currentValue)),
        ],
      ),
    );
  }
}
