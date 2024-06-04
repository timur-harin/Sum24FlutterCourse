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
      'Hello Flutter!',
      style: TextStyle(
        fontSize: 50,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.monitor_heart,
      size: 50,
      color: Colors.red,
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage(
          'https://avatars.mds.yandex.net/i?id=fbc6c0d87f9036610d1713409ac67fa0719b96d5-5101230-images-thumbs&n=13'),
      width: 800,
      height: 600,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      child: const Text('Button... hleba'),
      onPressed: () {
        print('Pressed');
      },
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
