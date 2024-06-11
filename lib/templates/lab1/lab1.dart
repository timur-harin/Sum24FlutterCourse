import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

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
        title: const Text('Lab 1'),
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
    return const FlutterLogo(
      size: 100,
    );
  }

  Widget exercise2() {
    return const FlutterLogo(
      size: 100,
    );
  }

  Widget exercise3() {
    return const FlutterLogo(
      size: 100,
    );
  }

  Widget exercise4() {
    return const FlutterLogo(
      size: 100,
    );
  }

  Widget exercise5() {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: const Color.fromARGB(100, 200, 200, 200),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          exercise1(),
          exercise2(),
        ],
      ),
    );
  }
}
