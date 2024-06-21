import 'package:education/templates/middleAssignment/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/session.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({super.key});

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  String dropdownValue = 'Excellent';
  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);

    final duration = sessionProvider.duration;
    final number = sessionProvider.numberCycles;
    final initColor = sessionProvider.color;
    return Scaffold(
        appBar: AppBar(
          title: Text('Overview'),
          backgroundColor: const Color.fromARGB(255, 194, 239, 245),
        ),
        backgroundColor: const Color.fromARGB(255, 194, 239, 245),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
            width: 350,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Color.fromARGB(255, 255, 208, 126),),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Text(
                'Total time: $duration sec',
                style: TextStyle(fontSize: 20),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                'Number of cycles: $number',
                style: TextStyle(fontSize: 20),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                'Initial temperature: $initColor',
                style: TextStyle(fontSize: 20),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              DropdownButton<String>(
                value: dropdownValue,
                items: <String>['Excellent', 'Good', 'Neutral', 'Bad']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      width: 200,
                      height: 50,
                      margin: const EdgeInsets.all(3.0),
                      padding: const EdgeInsets.all(3.0),
                      child: Text(value),
                      alignment: AlignmentDirectional.centerStart,
                    ),
                  );
                }).toList(),
                onChanged: (String? val) {
                  sessionProvider.feedback = val == 'Excellent'
                      ? SessionType.Excellent
                      : val == 'Good'
                          ? SessionType.Good
                          : val == 'Neutral'
                              ? SessionType.Neutral
                              : SessionType.Bad;
                  setState(() {
                    dropdownValue = val!;
                  });
                },
              ),
              ])
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 235, 255, 119)),
                      textStyle: WidgetStateProperty.all<TextStyle>(
                          const TextStyle(fontSize: 20)),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      sessionProvider.addSession(Session(
                        sessionProvider.color,
                        sessionProvider.feedback,
                        sessionProvider.duration,
                        sessionProvider.numberCycles,
                      ));
                      Navigator.of(context).pushNamed('/');
                    },
                    child: Text('Finish Over'),
                  )
                )
            ]
          )
      )
    );
  }
}
