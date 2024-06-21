import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'ShowerSessionTimer.dart';
import 'Constants.dart';
import 'Providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndSessionPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EndSessionPage();
}

class _EndSessionPage extends ConsumerState<EndSessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: FractionallySizedBox(
            widthFactor: defaultContainerFraction,
            heightFactor: 0.85,
            alignment: FractionalOffset.center,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.tealAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Session is over. How would you rate it?"),
                  FeedbackSlider(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          "/home", (_) => false
                        );
                      },
                      child: const Text("Return to home page")
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

class FeedbackSlider extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedbackSlider();
}

class _FeedbackSlider extends ConsumerState<FeedbackSlider> {
  double _sliderValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _sliderValue,
      max: 5,
      divisions: 5,
      label: _sliderValue.round().toString(),
      onChanged: (newValue) { setState(() {
        _sliderValue = newValue;
        ref.watch(feedbackProvider.notifier).setDefaultRate(_sliderValue as int);
      });
      },
    );
  }
}

Future updateSharedPrefs() async {
  final prefs = await SharedPreferences.getInstance();

}
