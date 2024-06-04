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
        fontSize: 20,
        color: Colors.yellow,
        fontWeight: FontWeight.bold,
      ),
      
    
    );

  }
    
  

  Widget exercise2() {
    return const Icon(
      Icons.house,
      size: 20,
      color: Colors.green,
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage("https://www.ixbt.com/img/n1/news/2024/4/3/photo_2024-05-08_07-49-41%20(2)_large.jpg"),
      width: 100,
      height: 100,
    );
  }

  Widget exercise4() {
    return TextButton (
      child: const Text("smth"),
      onPressed: () {
        print("Pressed");

      },

    );
    
  }

  Widget exercise5() {
    return  Column(
      children: [
        Container(
          child: const Text("something"),
          padding: const EdgeInsets.all(16.0),
          decoration: ShapeDecoration(shape: Border.all(color: Colors.blue)),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
        Container(
          child: const Icon(Icons.sunny),
          padding: const EdgeInsets.all(16.0),
          decoration: ShapeDecoration(shape: Border.all(color: Colors.red, width: 20)),
          margin: const EdgeInsets.all(20),
        ),
      ],
    );
  }
}
