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
        title: const Text('Lab 1'),
        backgroundColor: Colors.indigo,
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
    return Text("Hello Flutter!", 
      style: TextStyle(
      fontSize: 30, 
      color: Colors.indigo, 
      fontWeight: FontWeight.bold
      ),
    );
  }

  Widget exercise2() {
    return Icon(Icons.people_sharp, size: 100,color: Colors.indigo);
  }

  Widget exercise3() {
     return Image.network("https://img.joinfo.com/i/2020/03/800x0/5e725ed206a20.jpg", height: 1000, width: 500, );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print("Clicked!");
      },
      child: Container(
        color: Colors.indigo,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: const Text("Press", style: TextStyle(color: Colors.white)),
      ),
      );
  }

  Widget exercise5() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.indigo,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Some text widget below a kitten',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.indigo,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.landscape,
          color: Colors.white,
          size: 40,
        ),
      ),
    ],
  );
  }}