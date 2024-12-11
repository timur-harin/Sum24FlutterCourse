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
        title: const Text('Lab 1'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: myWidget(context),
    );
  }

  Widget myWidget(BuildContext context) {
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
          exercise4(context),
          const SizedBox(
            height: 25,
          ),
          exercise5(),
        ],
      ),
    );
  }

  Widget exercise1() {
    return const Text(
      'Flutter Rules',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 37.0,
        color: Colors.teal,
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.tv,
      color: Colors.teal,
      size: 42.0,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://i.pinimg.com/736x/b7/43/26/b74326865ca5feff316e6416a1b73ddc.jpg',
      width: 48.0,
      height: 64.0,
      fit: BoxFit.fill,
    );
  }

  Widget exercise4(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.tealAccent[700],
      ),
      child: const Text('Press me'),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Pressed'),
        ));
      },
    );
  }

  Widget exercise5() {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: const Text(
            'There\'s a Column!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(32.0),
          margin: const EdgeInsets.fromLTRB(4.0, 16.0, 4.0, 8.0),
          decoration: const FlutterLogoDecoration(),
          child: const Icon(
            Icons.egg_sharp,
            color: Colors.blue,
            size: 25.0,
          ),
        ),
      ],
    );
  }
}
