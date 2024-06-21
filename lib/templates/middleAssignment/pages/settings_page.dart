import 'dart:ui';

import 'package:flutter/material.dart';
import '../providers/provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  String dropdownValue = 'Hot';

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Custom settings'),
        backgroundColor: const Color.fromARGB(255, 194, 239, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 194, 239, 245),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            children: [
              Expanded(flex: 1, child: Text('')),
              Expanded(
                flex: 1,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter session duration of cycle',
                  ),
                  keyboardType: TextInputType.number,
                  controller: controller,
                ),
              ),
              Expanded(flex: 1, child: Text('')),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            children: [
              Expanded(flex: 1, child: Text('')),
              Expanded(
                flex: 1,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter number of cycles',
                  ),
                  keyboardType: TextInputType.number,
                  controller: controller2,
                ),
              ),
              Expanded(flex: 1, child: Text('')),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          DropdownButton<String>(
            value: dropdownValue,
            items: <String>['Hot', 'Cold'].map((String value) {
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
                ),
                alignment: AlignmentDirectional.centerStart,
              );
            }).toList(),
            onChanged: (String? val) {
              setState(() {
                dropdownValue = val!;
                sessionProvider.color = val.toString();
                sessionProvider.colorColor = val == 'Hot'
                    ? Color.fromARGB(255, 232, 145, 139)
                    : Color.fromRGBO(100, 170, 228, 1);
              });
            },
          ),
          Padding(padding: EdgeInsets.only(top: 110)),
          Container(
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    const Color.fromARGB(255, 235, 255, 119)),
                textStyle: WidgetStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 20)),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                sessionProvider.number = int.parse(controller.text);
                sessionProvider.numberCycles = int.parse(controller2.text);
                Navigator.of(context).pushNamed('/session');
              },
              child: Text('Start Session'),
            ),
          )
        ]),
      ),
    );
  }
}
