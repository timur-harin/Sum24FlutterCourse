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
    return Text(
      'Hello Flutter!',
      style: TextStyle(
        fontSize: 30,
        color: Colors.yellow,
        fontWeight: FontWeight.bold,
      ),
      );
  }

  Widget exercise2() {
    return const Icon(
      Icons.access_time,
      size: 100,
      color: Colors.red,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0lmTrDXEKioAUbgiVi4UX21hnmkfNKiPpaQ&s',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {print('Pressed');},
      child: Text('Жмать Сюда'),
    );
  }

  Widget exercise5() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Finish!!!',
          style: TextStyle(
            fontSize: 30,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.airplanemode_inactive,
          size: 80,
          color: Colors.yellow,
        ),
      ],
    );
  }
}
