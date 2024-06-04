// ignore_for_file: avoid_unnecessary_containers, avoid_print

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
    return const Text(
      'Hello world!',
      style: TextStyle(fontSize: 16.0, color: Colors.purple, fontWeight: FontWeight.bold),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.abc,
      color: Colors.blueAccent,
      size: 120.0,
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage('https://avatars.mds.yandex.net/i?id=f5dc55526e60138218b2edd8547bf6c1fc61d1ef-11951022-images-thumbs&n=13'),
      width: 100.0,
      height: 100.0,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: Colors.purple, backgroundColor: Colors.amber,
        textStyle: const TextStyle(fontSize: 20.0),
        padding: const EdgeInsets.all(20),
      ),
      child: const Text('Кнопочка!'),
    );
  }

  Widget exercise5() {
    return const Column(
      children: <Widget> [
        Text('Bagishaev \n Almas'),
        Padding(padding: EdgeInsets.all(20)),
        Icon(Icons.abc, size: 80.0, color: Colors.purple),
      ],
    );
  }
}