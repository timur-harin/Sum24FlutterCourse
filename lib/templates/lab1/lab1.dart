import 'dart:async';
import 'dart:math';

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
    return const Text(
      'Hello Flutter!',
      style: TextStyle(
        fontSize: 40,
        color: Colors.blue, 
        fontWeight: FontWeight.bold),
    );
  }

  Widget exercise2() {
    return const Icon( 
      Icons.dangerous,
      size: 100,
      color: Colors.amber,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://camo.githubusercontent.com/2374b035dd69d701b0351bc57b360f1f9fccdb736a389150ae76d9ec6b1f3c4c/68747470733a2f2f692e70696e696d672e636f6d2f6f726967696e616c732f39612f31352f30662f39613135306634656466336161613362356563343137666339373063353337322e676966',
      fit: BoxFit.fill,
      width: 100, 
      height: 50,
    );
  }

  Widget exercise4() {
    // ignore: avoid_print
    return TextButton(onPressed: () => print("Pressed"), style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
     child: const Text('Tap me'),
    );
  }

  Widget exercise5() {
    return Container(
      padding: const EdgeInsets.all(40.0),
      margin: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.purple,
      ),
      child: Column(
      children: <Container> [
        Container(child: const Text('the text')),
        Container(child: const Icon(Icons.face))]
      )
    ); 
  }
}
