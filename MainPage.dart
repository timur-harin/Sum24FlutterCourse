import 'package:flutter/material.dart';
import 'MainAppBarFlexibleSpace.dart';
import 'Constants.dart';
import 'SessionStoreWidget.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Shower Session Companion"),
          flexibleSpace: MainAppBarFlexibleSpace(),
        ),
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
                  SessionStoreWidget(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/beginSession");
                      },
                      child: const Text("Begin new session")
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
