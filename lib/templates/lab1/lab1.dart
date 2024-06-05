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
    return Container(
      child: const Text(
        'Hello Flutter!',
        style: TextStyle(
          fontSize: 100,
          color: Colors.red, 
          fontWeight: FontWeight.normal),
        )
      );
  }

  Widget exercise2() {
    return const Icon( 
      Icons.macro_off,
      size: 100,
      color: Colors.blue,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://media.istockphoto.com/id/184276818/ru/%D1%84%D0%BE%D1%82%D0%BE/%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B5-%D1%8F%D0%B1%D0%BB%D0%BE%D0%BA%D0%BE.jpg?s=612x612&w=0&k=20&c=HDH3wLEAvc7soT85pAcS4JOQu5KJ8xM9JOilVe1zFLI=',
      fit: BoxFit.fill,
      width: 80,
      height: 50,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: (){
        print("Pressed");
      },
      child: const Text(
        'Press me',
      ),
    );
    
    
  }

  Widget exercise5() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
      color: Colors.blue,
    ),
      child: Column(
      children: <Container> [
        Container(child: const Text('apple')),
        Container(child: const Icon(Icons.apple))]
      )
    ); 
  }
}