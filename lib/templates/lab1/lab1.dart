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
    return Text("Hello Flutter!", style: TextStyle(fontSize: 50, color: Colors.red, fontWeight: FontWeight.bold));
  }

  Widget exercise2() {
    return Icon(Icons.access_time, size: 100, color: Colors.blue);
  }

  Widget exercise3() {
    return Image.network("https://avatars.dzeninfra.ru/get-zen_doc/62917/pub_64d4ec7a57753700871fa094_64d61b4988e5a5673f56bd41/scale_1200", width: 500, height: 250, fit: BoxFit.cover);
  }

  Widget exercise4() {
    return TextButton(onPressed: () {print("Pressed");} , child: Text("Button"));
  }

  Widget exercise5() {
    return Column(children: <Widget>[
      Container(
        child: Text("I try:)"), 
        padding: const EdgeInsets.all(8.0), 
        margin: const EdgeInsets.all(10.0),
        color: Colors.amber[600]), 
      Container(child: Icon(Icons.abc), padding: const EdgeInsets.all(8.0), 
        margin: const EdgeInsets.all(10.0),
        color: Colors.amber[500])
      ]);
  }
}
