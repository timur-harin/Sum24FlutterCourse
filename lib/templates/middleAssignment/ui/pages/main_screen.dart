import "package:flutter/material.dart";

import "history_screen.dart";
import "new_session_screen.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shower Counter App'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: const Text("BIG DESCRIPTION HOW TO USE THIS ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
          )),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        mainAxisSize: MainAxisSize.max,
        textDirection: TextDirection.ltr,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const ShowerHistoryScreen()));
            },
            child: const Text("History Screen"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NewShowerSessionWidget()));
              },
              child: const Text("Add Session"))
        ],
      ),
    );
  }
}
