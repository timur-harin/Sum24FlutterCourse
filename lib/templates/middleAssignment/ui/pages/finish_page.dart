import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:education/templates/middleAssignment/data/provider/providers.dart';
import 'package:education/templates/middleAssignment/ui/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishPage extends ConsumerStatefulWidget {
  const FinishPage({super.key});

  @override
  ConsumerState<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends ConsumerState<FinishPage> {
  @override
  void initState() {
    super.initState();
    ref.read(sessionProvider);
  }

  final List<String> rateList = ["1", "2", "3", "4", "5"];

  String selected = "1";
  @override
  Widget build(BuildContext context) {
    final sessions = ref.watch(sessionProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          "Overview",
          style: headingStyle,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(paddingSize),
        child: Center(
          child: Column(
            children: [
              Text('Session Complete!',
                  style: subHeadingStyle.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.green)),
              const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Time of start: ",
                    style: bodyTextStyle,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: smallPaddingSize)),
                  Text(
                    sessions.sessions.last.startTime,
                    style: descriptionTextStyle,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Level: ",
                    style: bodyTextStyle,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: smallPaddingSize)),
                  Text(
                    sessions.sessions.last.level,
                    style: descriptionTextStyle,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total time: ",
                    style: bodyTextStyle,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: smallPaddingSize)),
                  Text(
                    sessions.sessions.last.totalTime,
                    style: descriptionTextStyle,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Number of cycles: ",
                    style: bodyTextStyle,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: smallPaddingSize)),
                  Text(
                    sessions.sessions.last.numbOfCycles.toString(),
                    style: descriptionTextStyle,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
              Text("Rate the session",
                  style: subHeadingStyle.copyWith(fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(top: paddingSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    child: DropdownButtonHideUnderline(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                color: buttonColor,
                                border: Border.all(
                                    color: buttonBorderColor, width: 1),
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          items: rateList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: bodyTextStyle,
                                    ),
                                  ))
                              .toList(),
                          value: selected,
                          onChanged: (value) {
                            setState(() {
                              selected = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 2 * paddingSize)),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: buttonStyle.copyWith(
                    backgroundColor:
                        WidgetStateProperty.all(Color(Colors.lightGreen.value)),
                  ),
                  onPressed: () {
                    sessions.editSessionRate(sessions.sessions.last, selected);
                    Navigator.of(context).pushNamed("/");
                  },
                  child: const Text(
                    "Rate",
                    style: buttonTextStyle,
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
