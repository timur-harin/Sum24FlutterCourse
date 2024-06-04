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
      'Hello World',
      style: TextStyle(
        fontSize: 48,
        color: Colors.amber,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage('https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExaThtNTE0NDZ4bzRieDdyNW5xeGFzaXJwMmpieDNtanNyZW5nNDUybyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/4dDquQRZZOPyo/giphy.webp'),
    );
  }

  Widget exercise4() {
    return ElevatedButton.icon(
      onPressed: () {
        print('Press me');
       },
      label: const Text('Pressed')
    );
  }

  Widget exercise5() {
    return Column (
      children: <Widget>[
          Container(
            color: Colors.blue,
            child: Text(
              'Just text',
              style: TextStyle(
                fontSize: 25,
                color: Colors.amber,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          Container(
            color: Colors.amber,
            child: Icon(
              size: 48,
              Icons.home
            )
          )
      ],
    );
  }
}
