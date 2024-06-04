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
        fontSize: 40,
        color: Colors.red,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget exercise2() {
    return Icon(
      Icons.home,
      size: 100,
      color: Colors.red,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Zunge_raus.JPG/300px-Zunge_raus.JPG',
      width: 150,
      height: 250,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () => print('Pressed'),
      child: Text(
        'Pressed',
      ),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
          ),
          child: Text(
            'Hello Flutter!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
          ),
          child: Icon(
            Icons.home,
            size: 50,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
