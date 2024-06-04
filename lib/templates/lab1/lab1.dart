import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const Lab1());

class Lab1 extends StatelessWidget {
  const Lab1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LAb1HomePage(),
    );
  }
}

class LAb1HomePage extends StatelessWidget {
  const LAb1HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.stars),
        title: const Text('Lab 2'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: myWidget(),
    );
  }

  Widget myWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          exercise1(),
          const SizedBox(
            height: 25,
          ),
          exercise2(),
          const SizedBox(
            height: 25,
          ),
          exercise3(),
          const SizedBox(
            height: 25,
          ),
          exercise4(),
          const SizedBox(
            height: 25,
          ),
          exercise5(),
        ],
      ),
    );
  }

  Widget exercise1() {
    return const Text("Hello Flutter", 
      textDirection: TextDirection.ltr,
      style: TextStyle(color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 40
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 100,
      color: Colors.purple,
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage('data:image/jpeg;base64,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'),
      fit: BoxFit.cover,
      width: 100,
      height: 100,
    );
  
  }

  Widget exercise4() {
    return  TextButton(
      child: Text(
        "Pressed",
        style: TextStyle(
          fontSize: 26,
        ),
      ),
      onPressed: () {
        print("the button has been pressed");
      },
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent)
          ),
          child: Text("data"),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent)
          ),
          child: Icon(
            Icons.dangerous
          ),
        )
      ],
    );
  }
}
