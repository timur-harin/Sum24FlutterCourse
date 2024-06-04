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
    return const Text('Hello Flutter!',
        style: TextStyle(
          fontSize: 50,
          color: Colors.pinkAccent,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget exercise2() {
    return const Icon(
      Icons.money,
      size: 100,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://avatars.dzeninfra.ru/get-zen_doc/1328418/pub_5d865696a3f6e400ad809169_5d8656e432335400af4cf357/scale_1200',
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    );
  }

  void tap() {
    print('Print');
  }

  Widget exercise4() {
    return TextButton(
      onPressed: tap,
      child: Text('Tap'),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Text(
          'test',
          style: TextStyle(
            fontSize: 50,
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Icon(Icons.home),
        ),
      ],
    );
  }
}
