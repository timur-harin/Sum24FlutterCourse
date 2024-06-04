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
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );

  }


  Widget exercise2() {
    return const Icon(
      Icons.house,
      size: 15,
      color: Colors.black,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://avatars.dzeninfra.ru/get-zen_doc/9427399/pub_6488513803e5b546e33e2b98_648856525c6cb5626436de3c/scale_1200',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }


  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print("thx");
      },
      child: Text('Press pls'),
    );
  }


  Widget exercise5() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            color: Colors.lightBlue[60],
          ),
          child: const Text("pampam"),
        ),
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            color: Colors.orange[60],
          ),
          child: const Icon(Icons.sunny),
        ),
      ],
    );
  }
}

