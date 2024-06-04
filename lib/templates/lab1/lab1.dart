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
      'Hello Flutter!',
      style: TextStyle(
        fontSize: 80,
        color: Color.fromARGB(255, 24, 182, 134),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 120,
      color: Colors.blue,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print('Pressed');
      },
      child: Text("BUTTON"),
    );
  }

  Widget exercise5() {
    return Column(
       children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(40),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal),
            borderRadius: BorderRadius.vertical(),
          ),
          child: Text("data"),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(40),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(Icons.favorite, size: 70),
        )
       ],
    );
}
