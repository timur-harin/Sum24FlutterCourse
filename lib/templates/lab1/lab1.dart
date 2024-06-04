import 'package:flutter/cupertino.dart';
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
    return const Text(
      "Hello Flutter!",
      style: TextStyle(
          fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 100,
      color: Colors.red,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://target.scene7.com/is/image/Target/GUEST_1313084a-0ba5-4ce0-9957-1f4784e605d2?wid=488&hei=488&fmt=pjpeg',
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print("Pressed");
      },
      child: const Text("Button"),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10, top: 10),
          height: 100,
          decoration: const BoxDecoration(color: Colors.orange),
          child: const Text("Lol",),
        ),
        Container(
            decoration: const BoxDecoration(color: Colors.red),
            width: 210,
            child: const Icon(
              Icons.phone,
              size: 31,
            )),
      ],
    );
  }
}
