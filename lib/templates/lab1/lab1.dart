import 'package:flutter/material.dart';

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
    return Text("Hello, Flutter!",style: TextStyle(fontSize: 40, color: Colors.blue,fontWeight: FontWeight.bold));
  }

  Widget exercise2() {
    return Icon(Icons.holiday_village, size: 100, color: Colors.deepOrange);
  }

  Widget exercise3() {
    return Image.network("http://mtdata.ru/u22/photo0850/20132377487-0/original.jpg", width: 100, height: 100, fit: BoxFit.cover);
  }

  Widget exercise4() {
    return TextButton(onPressed: () {print("Pressed.I try my best");}, child: Text("Click!"));
  }

  Widget exercise5() {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 120, 18, 127),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child:
        Text(
          "It is hard",
          style: TextStyle(fontSize: 40, color: Colors.amberAccent)
          )
      ),
      Container(
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 127, 43, 18),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child:
        Icon(Icons.access_alarm, size: 40, color: Colors.pinkAccent)
      )
    ]
    );
  }
}
