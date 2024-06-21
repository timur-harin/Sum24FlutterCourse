import 'package:education/templates/middleAssignment/data/shower_take.dart';
import 'package:education/templates/middleAssignment/providers/tempreture_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/duration_provider.dart';
import '../../providers/cycles_provider.dart';
import '../../providers/shower_take_provider.dart';


const List<Widget> tempreture = <Widget>[
  Text('Cold'),
  Text("Hot")
];


class SetupPage extends ConsumerStatefulWidget {
  SetupPage({super.key});

  @override
  ConsumerState<SetupPage> createState() => _SetupPage();
}

class _SetupPage extends ConsumerState<SetupPage> {
  final TextEditingController cyclesController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  final List<bool> _selectedTempreture = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Start a Shower!', 
          style: TextStyle(
            color: Color(0xFF123C69),
          ),
        ),
        backgroundColor: Color(0xFFEEE2DC),
      ),
      backgroundColor: Color(0xFFEEE2DC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.8,
              child: 
              Column(
                children: [
                  TextField(
                    controller: cyclesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cycles',
                    ),
                    style: const TextStyle(
                      color: Color(0xFFAC3B61)
                    ),
                    
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Duration',
                    ),
                    style: const TextStyle(
                      color: Color(0xFFAC3B61)
                    ),
                  ),
                ],
              )
            ),
            const Text(
              "Choose tempreture to start",
              style: TextStyle(
                color: Color(0xFF123C69),
              ),
            ),
            ToggleButtons(
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    if (index == 0) {
                      ref.read(tempretureProvider.notifier).setState("Cold Now");
                    } else {
                      ref.read(tempretureProvider.notifier).setState("Hot Now");
                    }
                    for (int i = 0; i < _selectedTempreture.length; i++) {
                      _selectedTempreture[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Color(0xFFEDC7B7),
                selectedColor: Colors.white,
                fillColor: Color(0xFFEDC7B7),
                color: Colors.black,
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: _selectedTempreture,
                children: tempreture,
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(cyclesProvider.notifier).setState(int.parse(cyclesController.text));
                ref.read(durationProvider.notifier).setState(int.parse(durationController.text));
                Navigator.of(context).pushNamed('/takeShower');
              },
              style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Color(0xFFEEE2DC)),
                  backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF123C69)),
              ),
              child: const Text('Take a shower!'),
            ),
          ]
        )
      )
    );
  }
}